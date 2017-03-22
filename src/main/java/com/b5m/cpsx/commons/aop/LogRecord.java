package com.b5m.cpsx.commons.aop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
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
 * 记录日志的
 */
@Intercepts({ @Signature(type = Executor.class, method = "update", args = {
		MappedStatement.class, Object.class }) })
@Component
public class LogRecord implements Interceptor {

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

		if (mappedStatement.getId().matches(pageSqlId)) {
			insertLog(configuration, boundSql, sqlId);
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
			String sqlId) {
		String action = this.getUri();
		String sql = showSql(configuration, boundSql);
		String[] sqlSplit = sql.split(" ");
		String method_type = sqlSplit[0];
		String tableName = null;
		if ("update".equals(method_type.toLowerCase())) {
			tableName = sqlSplit[1];
		} else if ("insert".equals(method_type.toLowerCase())
				|| "delete".equals(method_type.toLowerCase())) {
			tableName = sqlSplit[2];
		}

		Long userId = 0L;
		String userName = null;
		String userIp = this.getIp();
		User user = this.getLoginUser();
		if (user != null) {
			userId = (long) user.getId();
			userName = user.getUserName();
			userIp = this.getIp();
		}

		PreparedStatement insertStmt = null;
		Connection connection = null;
		String insertSql = "INSERT INTO user_exe_logs("
				+ "log_type, exe_table_name, exe_sql_id, exe_sql, exe_action, user_id, user_name, user_ip)"
				+ "values (?,?,?,?,?,?,?,?)";
		try {
			connection = SpringContextUtils.getBean("dataSource",
					DruidDataSource.class).getConnection();
			insertStmt = connection.prepareStatement(insertSql);
			insertStmt.setString(1, method_type);
			insertStmt.setString(2, tableName);
			insertStmt.setString(3, sqlId);
			insertStmt.setString(4, sql);
			insertStmt.setString(5, action);
			insertStmt.setLong(6, userId);
			insertStmt.setString(7, userName);
			insertStmt.setString(8, userIp);
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
		/*HttpSession session = request.getSession(false);
		if (session == null) {
			return null;
		}
		Object obj = session.getAttribute(AdminConstant.user_session_key);
		if (!(obj instanceof User)) {
			return null;
		}
		User user = (User) obj;*/
		return GetUserFromCookieUtils.getUser(request);
	}

	private String getIp() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
		return request.getRemoteAddr();
	}

	private String getUri() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
		return request.getRequestURI();
	}

}
