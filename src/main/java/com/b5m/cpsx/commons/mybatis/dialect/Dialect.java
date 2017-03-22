package com.b5m.cpsx.commons.mybatis.dialect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.executor.ErrorContext;
import org.apache.ibatis.executor.ExecutorException;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.mapping.ParameterMode;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.property.PropertyTokenizer;
import org.apache.ibatis.scripting.xmltags.ForEachSqlNode;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.type.TypeHandler;
import org.apache.ibatis.type.TypeHandlerRegistry;

public abstract class Dialect {

	public static enum Type {
		MYSQL, ORACLE, DB2, MSSQL58, MSSQL12,POSTGRESQL
	}

	public abstract String getLimitString(String sql, int skipResults,
			int maxResults);

	/**
	 * 查boundSql不分页时能查出的总的数据量
	 * @param boundSql
	 * @param connection
	 * @param mappedStatement
	 * @param parameterObject
	 * @return
	 * @throws RuntimeException
	 */
	public int getDataCount(BoundSql boundSql, Connection connection,
			MappedStatement mappedStatement, Object parameterObject)throws RuntimeException {
		String sql = boundSql.getSql();
		String countSql = "SELECT COUNT(0) FROM (" + sql + ") ttttttt"; // 记录统计
		PreparedStatement countStmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			countStmt = connection.prepareStatement(countSql);
			BoundSql countBS = new BoundSql(mappedStatement.getConfiguration(),
					countSql, boundSql.getParameterMappings(), parameterObject);
			setParameters(countStmt, mappedStatement, countBS, parameterObject);
			rs = countStmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			
			throw new RuntimeException(e.getMessage(),e);
		} finally {
			try {
				if(rs!=null)rs.close();
				if(countStmt != null )countStmt.close();
			} catch (Exception e) {
				throw new RuntimeException(e.getMessage(),e);
			}
		}

		return count;
	}

	//把参数设置到countSql里
	private void setParameters(PreparedStatement ps,
			MappedStatement mappedStatement, BoundSql boundSql,
			Object parameterObject) throws SQLException {
		ErrorContext.instance().activity("setting parameters")
				.object(mappedStatement.getParameterMap().getId());
		List<ParameterMapping> parameterMappings = boundSql
				.getParameterMappings();
		if (parameterMappings != null) {
			Configuration configuration = mappedStatement.getConfiguration();
			TypeHandlerRegistry typeHandlerRegistry = configuration
					.getTypeHandlerRegistry();
			MetaObject metaObject = parameterObject == null ? null
					: configuration.newMetaObject(parameterObject);
			for (int i = 0; i < parameterMappings.size(); i++) {
				ParameterMapping parameterMapping = parameterMappings.get(i);
				if (parameterMapping.getMode() != ParameterMode.OUT) {
					Object value;
					String propertyName = parameterMapping.getProperty();
					PropertyTokenizer prop = new PropertyTokenizer(propertyName);
					if (parameterObject == null) {
						value = null;
					} else if (typeHandlerRegistry
							.hasTypeHandler(parameterObject.getClass())) {
						value = parameterObject;
					} else if (boundSql.hasAdditionalParameter(propertyName)) {
						value = boundSql.getAdditionalParameter(propertyName);
					} else if (propertyName
							.startsWith(ForEachSqlNode.ITEM_PREFIX)
							&& boundSql.hasAdditionalParameter(prop.getName())) {
						value = boundSql.getAdditionalParameter(prop.getName());
						if (value != null) {
							value = configuration.newMetaObject(value)
									.getValue(
											propertyName.substring(prop
													.getName().length()));
						}
					} else {
						value = metaObject == null ? null : metaObject
								.getValue(propertyName);
					}
					TypeHandler typeHandler = parameterMapping.getTypeHandler();
					if (typeHandler == null) {
						throw new ExecutorException(
								"There was no TypeHandler found for parameter "
										+ propertyName + " of statement "
										+ mappedStatement.getId());
					}
					typeHandler.setParameter(ps, i + 1, value,
							parameterMapping.getJdbcType());
				}
			}
		}
	}

}