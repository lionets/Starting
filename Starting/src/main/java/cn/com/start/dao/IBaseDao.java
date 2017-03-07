package cn.com.start.dao;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Param;

/**
 * Dao基础接口，所有Dao应该继承于此接口
 * @author xiezhh
 *
 * @param <T>
 * @param <Pk>
 */
public interface IBaseDao<E extends Serializable, Id extends Serializable> {

	/**
	 * 插入数据
	 * 
	 * @param entity
	 * @return
	 */
	int insert(E entity);

	/**
	 * 根据主键更新数据
	 * 
	 * @param entity
	 * @return
	 */
	int updateById(E entity);

	/**
	 * 根据主键删除数据
	 * 
	 * @param pk
	 * @return
	 */
	int deleteById(Id id);

	/**
	 * 根据主键查找数据
	 * 
	 * @param pk
	 * @return
	 */
	E findById(Id id);
	
	/**
	 * 根据主键集合查找数据
	 * @param ids
	 * @return
	 */
	List<E> findByIds(Id[] ids);

	
	/**
	 * 根据主键查找数据
	 * 
	 * @param entity
	 * @return
	 */
	E findByEntityId(E entity);
	
	/**
	 * 查询所有数据
	 * 
	 * @return
	 */
	List<E> findAll();

	/**
	 * 根据组合条件查询数据
	 * 
	 * @param entity
	 * @return
	 */
	List<E> findByCondition(E condition);
	
	
	/**
	 * 统计表数据量
	 * @return
	 */
	Integer countAll();
	
	/**
	 * 根据条件统计表数据量
	 * @param entity
	 * @return
	 */
	Integer countByCondition(E condition);
	
	
	/**
	 * 唯一性检查
	 * @param dto
	 * @param checkFieldName
	 * @return
	 */
	Integer checkUnique(@Param("dto") E dto, @Param("uniquePropertyNames") String uniquePropertyNames);

	/**
	 * 根据选择的到处excel条数到处excel数据
	 * @return
	 
	List<ExcelDataDTO> exportExcelDataByIds(Id[] ids);*/
	
	/**
	 * 根据查询条件到处excel数据
	 * @return
	 
	List<ExcelDataDTO> exportExcelDataByCondition(E condition);*/
}
