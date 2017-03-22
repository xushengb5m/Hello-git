package com.b5m.cpsx.commons.aop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.type.TypeHandlerRegistry;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.alibaba.druid.pool.DruidDataSource;
import com.b5m.cpsx.model.User;
import com.b5m.cpsx.utils.GetUserFromCookieUtils;
import com.b5m.cpsx.utils.SpringContextUtils;

/*
 * 时间轴的操作记录拦截，拦截(websiteMapper|cpsxUserMapper|settleMapper|earnerActivityMapper)这些表中的增删改
 */
@Intercepts({ @Signature(type = Executor.class, method = "update", args = {
		MappedStatement.class, Object.class }) })
@Component
public class LogOperationInteceptor implements Interceptor {

	private static String pageSqlId = ""; // mapper.xml中需要拦截的ID(正则匹配)
	private Properties properties;

	public Object intercept(Invocation invocation) throws Throwable {
		MappedStatement mappedStatement = (MappedStatement) invocation
				.getArgs()[0];
		Object parameter = null;

		if (invocation.getArgs().length > 1) {
			parameter = invocation.getArgs()[1];
		}

		String sqlId = mappedStatement.getId();
		pageSqlId = properties.getProperty("pageSqlId");
		BoundSql boundSql = mappedStatement.getBoundSql(parameter);

		Configuration configuration = mappedStatement.getConfiguration();
		// Object returnValue = null;
		// long start = System.currentTimeMillis();

		if (sqlId.matches(pageSqlId)) {
			String msg = getMessage();
			insertLog(configuration, boundSql, sqlId,msg);
		}
		Object returnValue = invocation.proceed();
		// long end = System.currentTimeMillis();
		// long time = (end - start);

		return returnValue;

	}

	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}

	public void setProperties(Properties properties) {
		this.properties = properties;

	}

	public void insertLog(Configuration configuration, BoundSql boundSql,
			String sqlId,String msg) {
		String sql = showSql(configuration, boundSql);
		String[] sqlSplit = sql.split(" ");
		String method_type = sqlSplit[0];
		
		String mapper = sqlId.split("\\.")[0];
		String target = "";
		if(mapper.equals("websiteMapper")){
			target = "站点";
		}else if(mapper.equals("settleMapper")){
			target = "结算申请";
		}else if(mapper.equals("earnerActivityMapper")){
			target = "推广活动";
		}
		int userId = 0;
		User user = this.getLoginUser();
		if (user != null) {
			userId =  user.getId();
		}
		PreparedStatement insertStmt = null;
		Connection connection = null;
		String insertSql = "INSERT INTO cpsx_sys_dim_operation_record("
				+ "user_id, operate, target,message, operate_time, note)"
				+ "values (?,?,?,?,now(),?)";
		try {
			connection = SpringContextUtils.getBean("dataSource",
					DruidDataSource.class).getConnection();
			insertStmt = connection.prepareStatement(insertSql);
			insertStmt.setInt(1, userId);
			insertStmt.setString(2, method_type);
			insertStmt.setString(3, target);
			insertStmt.setString(4, msg);
			insertStmt.setString(5, sqlId);
			insertStmt.executeUpdate();
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage(), e);
		} finally {
			try {
				if (insertStmt != null)
					insertStmt.close();
				if (connection != null)
					connection.close();
			} catch (Exception e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}

	}

	public static String showSql(Configuration configuration, BoundSql boundSql) {
		Object parameterObject = boundSql.getParameterObject();
		List<ParameterMapping> parameterMappings = boundSql
				.getParameterMappings();
		String sql = boundSql.getSql().replaceAll("[\\s]+", " ");
		if (parameterMappings.size() > 0 && parameterObject != null) {
			TypeHandlerRegistry typeHandlerRegistry = configuration
					.getTypeHandlerRegistry();
			if (typeHandlerRegistry.hasTypeHandler(parameterObject.getClass())) {
				sql = sql.replaceFirst("\\?",
						getParameterValue(parameterObject));
			} else {
				MetaObject metaObject = configuration
						.newMetaObject(parameterObject);
				for (ParameterMapping parameterMapping : parameterMappings) {
					String propertyName = parameterMapping.getProperty();
					if (metaObject.hasGetter(propertyName)) {
						Object obj = metaObject.getValue(propertyName);
						sql = sql.replaceFirst("\\?", getParameterValue(obj));
					} else if (boundSql.hasAdditionalParameter(propertyName)) {
						Object obj = boundSql
								.getAdditionalParameter(propertyName);
						sql = sql.replaceFirst("\\?", getParameterValue(obj));
					}
				}
			}
		}
		return sql;
	}

	private static String getParameterValue(Object obj) {
		String value = null;
		if (obj instanceof String) {
			value = "'" + obj.toString() + "'";
		} else if (obj instanceof Date) {
			DateFormat formatter = DateFormat.getDateTimeInstance(
					DateFormat.DEFAULT, DateFormat.DEFAULT, Locale.CHINA);
			value = "'" + formatter.format(new Date()) + "'";
		} else {
			if (obj != null) {
				value = obj.toString();
			} else {
				value = "";
			}
		}
		return value;
	}

	// 获取用户的信息，可以利用Spring随时随地获得Request，需要在web.xml中加配置
	/*
	 * <listener> <listener-class>org.springframework.web.context.request.
	 * RequestContextListener</listener-class> </listener>
	 */

	private User getLoginUser() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
		return GetUserFromCookieUtils.getUser(request);
	}

	private String getUri() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
		return request.getRequestURI();
	}
	
	private String getMessage(){
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
		return (String) request.getAttribute("msg");
	}

}
