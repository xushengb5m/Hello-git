package com.b5m.cpsx.commons.mybatis.dialect;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.util.Map;
import java.util.Properties;

import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.factory.DefaultObjectFactory;
import org.apache.ibatis.reflection.wrapper.DefaultObjectWrapperFactory;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.RowBounds;
import org.springframework.util.StringUtils;

import com.b5m.cpsx.model.Page;



@Intercepts({ @Signature(type = StatementHandler.class, method = "prepare", args = { Connection.class }) })
public class PagePlugin implements Interceptor {

	private final static Log log = LogFactory.getLog(PagePlugin.class);

	private static String dialectStr = ""; // 数据库方言
	private static String pageSqlId = ""; // mapper.xml中需要拦截的ID(正则匹配)

	public Object intercept(Invocation invocation) throws Throwable {

		StatementHandler statementHandler = (StatementHandler) invocation
				.getTarget();

		BoundSql boundSql = statementHandler.getBoundSql();

		MetaObject metaStatementHandler = MetaObject.forObject(
				statementHandler, new DefaultObjectFactory(),
				new DefaultObjectWrapperFactory());

		MappedStatement mappedStatement = (MappedStatement) metaStatementHandler
				.getValue("delegate.mappedStatement");
		if (mappedStatement.getId().matches(pageSqlId)) {
			RowBounds rowBounds = (RowBounds) metaStatementHandler
					.getValue("delegate.rowBounds");
			if (rowBounds == null) {
				return invocation.proceed();
			}

			Configuration configuration = (Configuration) metaStatementHandler
					.getValue("delegate.configuration");
			
			Connection connection = (Connection) invocation.getArgs()[0];
			
			DatabaseMetaData md = connection.getMetaData();
			String dialectStr1 = md.getDatabaseProductName().toUpperCase();
//			System.out.println(md.getDatabaseProductVersion());
			

			Dialect.Type databaseType = null;

			databaseType = Dialect.Type.valueOf(dialectStr1);

			if (databaseType == null) {

				throw new RuntimeException(
						"the value of the dialect property in configuration.xml is not defined : "
								+ configuration.getVariables().getProperty(
										"dialect"));

			}

			Dialect dialect = null;

			switch (databaseType) {
			case ORACLE:
				dialect = new OracleDialect();
				break;
			case POSTGRESQL:
				dialect =new PostgreDialect();
				break;
			case MYSQL:
				dialect =new MysqlDialect();
				break;
			}
			Object paramObj = boundSql.getParameterObject();
			if (paramObj == null) {
				throw new RuntimeException("分页参数对象未实例化！");
			}

			String sql = boundSql.getSql();

			// 查询总条数
			int count = 0;
//			Connection connection = (Connection) invocation.getArgs()[0];

			count = dialect.getDataCount(boundSql, connection, mappedStatement,
					paramObj);

			Page page = setResult(paramObj, count);//将查询出的总条数设置到传进来的page对象里
			int startindex = page.getPageNo();
			metaStatementHandler.setValue("delegate.boundSql.sql", dialect
					.getLimitString(sql, startindex,
							(Integer) page.getPageSize()));

			metaStatementHandler.setValue("delegate.rowBounds.offset",
					RowBounds.NO_ROW_OFFSET);

			metaStatementHandler.setValue("delegate.rowBounds.limit",
					RowBounds.NO_ROW_LIMIT);

			if (log.isDebugEnabled()) {

				log.debug("生成分页SQL : " + boundSql.getSql());

			}
		}

		return invocation.proceed();

	}

	public Object plugin(Object target) {
		// 当目标类是StatementHandler类型时，才包装目标类，否者直接返回目标本身,减少目标被代理的
		// 次数
		if (target instanceof StatementHandler) {
			return Plugin.wrap(target, this);
		} else {
			return target;
		}
	}

	public void setProperties(Properties properties) throws RuntimeException {
		dialectStr = properties.getProperty("dialect");
		if (StringUtils.isEmpty(dialectStr)) {
			throw new RuntimeException("dialect property is not found!");
		}
		pageSqlId = properties.getProperty("pageSqlId");
		if (StringUtils.isEmpty(pageSqlId)) {
			throw new RuntimeException("pageSqlId property is not found!");
		}
	}

	@SuppressWarnings("unchecked")
	private Page setResult(Object paramObj, int count) {
		Map<String, Object> params = null;
		Page page = null;
		// dao层能把Page对象传过来，可以在这一层把count查出来再设置到page对象里，service什么都不用做，
		//当mapper的方法参数不止Page一个时，Page的参数名称必须用@Param("page")重命名
		if (paramObj != null && paramObj instanceof Map) { // 参数就是Page实体
			params = (Map<String, Object>) paramObj;
			page = (Page) params.get("page");
		}
		else if (paramObj instanceof Page) { // 参数就是Page实体
			page = (Page) paramObj;
		} 
		else {
			throw new RuntimeException("查询分页的方法参数类型不对!分页查询参赛必须为"+Page.class+";或者包含参赛： "+Page.class);
		}
		page.setTotal(count);
		return page;
	}
	
}
	