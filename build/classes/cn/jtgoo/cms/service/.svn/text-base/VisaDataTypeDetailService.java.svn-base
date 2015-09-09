package cn.jtgoo.cms.service;

import java.util.List;

import cn.jtgoo.cms.base.BaseDao;
import cn.jtgoo.cms.domain.CusDat;
import cn.jtgoo.cms.domain.DataTypeDetail;

public interface VisaDataTypeDetailService extends BaseDao<DataTypeDetail> {

	List<DataTypeDetail> getListByPId(Long id,String type);
	List<CusDat> getListByvisaOrderId(Long id,String type);
	DataTypeDetail getByIdNew(Long id);
	/**
	 * 查询中间表
	 * @param id
	 * @return
	 */
	List<CusDat> findListByVisaPid(Long id,Long visaorderId);
	List<CusDat> findListByVisaPid(Long id);
	List<CusDat> findCusByPidAndCid(Long valueOf, Long customerId);
	List<CusDat> findListByOrderId(Long visaorderId);
	CusDat  findCusDatByid(String id);
	void updateCusDat(CusDat cusDat);
	void updateRelationByOrderId(Long id, String customerIds);
	void saveDataTypeDetailList(List<DataTypeDetail> dataTypeDetailList);


}
