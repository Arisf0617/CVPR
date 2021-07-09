
package dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import pojo.Data;
import utils.DataSourceUtils;

public class DataDao {

	public List<Data> getData() throws SQLException {
		QueryRunner queryRunner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from cvpr ";
		List<Data> dataList = queryRunner.query(sql, new BeanListHandler<Data>(Data.class));
		return dataList;
		
		
	}

	public List<Data> getLink(String name) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from cvpr where papername like ?";
		List<Data> dataList = queryRunner.query(sql, new BeanListHandler<Data>(Data.class),"%"+name+"%");
		return dataList;
	}
	
	public List<Data> getLink2(String name,String author,String ab) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from cvpr where papername like ? and author like ? and ab like ? ";
		List<Data> dataList = queryRunner.query(sql, new BeanListHandler<Data>(Data.class),"%"+name+"%","%"+author+"%","%"+ab+"%");
		return dataList;
	}

}
 