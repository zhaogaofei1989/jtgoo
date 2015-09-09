package cn.jtgoo.cms.service.impl;

import java.util.List;

import org.hibernate.Query;

import cn.jtgoo.cms.base.BaseDaoImpl;
import cn.jtgoo.cms.domain.CusDat;
import cn.jtgoo.cms.domain.DataTypeDetail;
import cn.jtgoo.cms.service.VisaDataTypeDetailService;

@SuppressWarnings("unchecked")
public class VisaDataTypeDetailServiceImpl extends BaseDaoImpl<DataTypeDetail>
		implements VisaDataTypeDetailService {

	public List<DataTypeDetail> getListByPId(Long id, String type) {
		Query query = this.getSession().createQuery(
				"from DataTypeDetail c where c.visaProduct.id=" + id
						+ " and c.type=" + type + " order by sort ASC");
		return query.list();
	}

	public List<CusDat> getListByvisaOrderId(Long id, String type) {
		Query query = this
				.getSession()
				.createSQLQuery(
						"select jcd.id,jcd.reason, jcd.visaorderId,jcd.analysis,jcd.results,jcd.type,jcd.visaProductId, jcd.customerName,jcd.datatypeName,jcd.datatypedetailTitle,jcd.status,jcd.customerId,jcd.customerName,jcd.original,jcd.remarks,jcd.datatypeDetailId,jcd.copy from jtgoo_cus_dat jcd where jcd.id="
								+ id).addEntity(CusDat.class);
		return query.list();
	}

	public DataTypeDetail getByIdNew(Long id) {
		return (DataTypeDetail) this.getSession().createQuery(
				"from DataTypeDetail c where c.id=" + id).uniqueResult();
	}

	public List<CusDat> findListByVisaPid(Long id) {
		Query query = this
				.getSession()
				.createSQLQuery(
						"select jcd.id,jcd.reason, jcd.visaorderId,jcd.analysis,jcd.results, jcd.customerId,jcd.type,jcd.datatypeDetailId,jcd.visaProductId,jcd.copy,jc.name as customerName ,jdt.name as datatypeName ,jdtd.title as datatypedetailTitle ,jcd.original,jcd.copy,jcd.remarks,jcd.status,jcd.visaorderId from jtgoo_cus_dat jcd ,jtgoo_customer jc,jtgoo_datatypedetail jdtd ,jtgoo_datatype jdt where jcd.customerId=jc.id and jcd.datatypeDetailId =jdtd.id  and jdt.id=jdtd.dataTypeId and jcd.visaProductId="
								+ id).addEntity(CusDat.class);
		return query.list();
	}

	@SuppressWarnings("unchecked")
	public List<CusDat> findListByVisaPid(Long id, Long visaorderId) {
//		return this
//		.getSession()
//		.createSQLQuery(
//				"select jcd.id,jcd.reason,jcd.visaorderId, jcd.analysis,jcd.results, jcd.type,jcd.customerId,jcd.datatypeDetailId,jcd.visaProductId,jcd.copy,jc.name as customerName ,jdt.name as datatypeName ,jdtd.title as datatypedetailTitle ,jcd.original,jcd.copy,jcd.remarks,jcd.status from jtgoo_cus_dat jcd ,jtgoo_customer jc,jtgoo_datatypedetail jdtd ,jtgoo_datatype jdt where jcd.customerId=jc.id and jcd.datatypeDetailId =jdtd.id  and jdt.id=jdtd.dataTypeId and jcd.visaorderId="
//				+ visaorderId).addEntity(CusDat.class).list();
		return this
				.getSession()
				.createSQLQuery(
						"SELECT jcd.id as id,jcd.visaProductId,jcd.visaorderId,jcd.status,jcd.results,jcd.customerName,jcd.analysis,jcd.type,jcd.customerId as customerId ,jcd.datatypeDetailId,jcd.original,jcd.copy,jcd.remarks,jcd.reason,title as datatypedetailTitle,content,jdtname as datatypeName FROM jtgoo_cus_dat AS jcd LEFT JOIN jtgoo_customer AS jc ON jcd.customerId = jc.id LEFT JOIN ( SELECT jdtd.content, jdtd.id, jdtd.title,jdt.name as jdtname FROM jtgoo_datatypedetail AS jdtd, jtgoo_datatype AS jdt WHERE jdtd.dataTypeId = jdt.id ) AS jd ON jcd.datatypeDetailId = jd.id WHERE jcd.visaorderId="
								+ visaorderId).addEntity(CusDat.class).list();
	}

	public List<CusDat> findListByOrderId(Long visaorderId) {
		// return this.getSession().createQuery("from CusDat c").list();
		return this
				.getSession()
				.createSQLQuery(
						"select jcd.id,jcd.reason,jcd.visaorderId, jcd.analysis,jcd.results,jcd.customerId,jcd.datatypeDetailId,jcd.visaProductId,jcd.copy,jc.name as customerName ,jdt.name as datatypeName ,jdtd.title as datatypedetailTitle ,jcd.original,jcd.copy,jcd.remarks,jcd.status,jcd.type from jtgoo_cus_dat jcd ,jtgoo_customer jc,jtgoo_datatypedetail jdtd ,jtgoo_datatype jdt where jcd.customerId=jc.id and jcd.datatypeDetailId =jdtd.id  and jdt.id=jdtd.dataTypeId and jcd.visaorderId="
								+ visaorderId).addEntity(CusDat.class).list();
	}

	public List<CusDat> findCusByPidAndCid(Long productId, Long customerId) {
		return getSession()
				.createSQLQuery(
						"select jcd.id,jcd.reason,jcd.visaorderId, jcd.analysis,jcd.results, jcd.type,jcd.customerId,jcd.datatypeDetailId,jcd.visaProductId,jcd.copy,jc.name as customerName ,jdt.name as datatypeName ,jdtd.title as datatypedetailTitle ,jcd.original,jcd.copy,jcd.remarks,jcd.status from jtgoo_cus_dat jcd ,jtgoo_customer jc,jtgoo_datatypedetail jdtd ,jtgoo_datatype jdt where jcd.customerId=jc.id and jcd.datatypeDetailId =jdtd.id  and jdt.id=jdtd.dataTypeId and jcd.visaProductId="
								+ productId
								+ " and jcd.customerId="
								+ customerId).addEntity(CusDat.class).list();
	}

	public CusDat findCusDatByid(String id) {
		return (CusDat) this
				.getSession()
				.createSQLQuery(
						"select jcd.id,jcd.reason, jcd.visaorderId, jcd.analysis,jcd.results, jcd.type,jcd.customerId ,jcd.datatypeDetailId,jcd.visaProductId,jcd.copy,jcd.customerName ,jcd.datatypeName ,jcd.datatypedetailTitle ,jcd.original, jcd.copy,jcd.remarks,jcd.status,jcd.type from jtgoo_cus_dat jcd  where jcd.id="
								+ id).addEntity(CusDat.class).uniqueResult();

	}

	public void updateCusDat(CusDat cusDat) {
		Query query = getSession().createSQLQuery(
				"update jtgoo_cus_dat set reason=? ,analysis=?,results=? where id="
						+ cusDat.getId());
		query.setString(0, cusDat.getReason());
		query.setString(1, cusDat.getAnalysis());
		query.setString(2, cusDat.getResults());
		query.executeUpdate();

	}

	public void updateRelationByOrderId(Long orderId, String customerIds) {
		/**
		 * 以分号进行切割
		 */
		String[] str = customerIds.split(",");
		for (int i = 0; i < str.length; i++) {
			Query query = getSession().createSQLQuery(
					"update jtgoo_cus_dat set visaorderId=" + orderId
							+ " where customerId=" + str[i]);
			query.executeUpdate();
			System.out.println(query.getQueryString());
			if (i % 10 == 0) {
//				getSession().flush();
//				getSession().clear();
			}
		}

	}

	public void saveDataTypeDetailList(List<DataTypeDetail> dataTypeDetailList) {
		for (int i=0;i<dataTypeDetailList.size();i++) {
			getSession().save(dataTypeDetailList.get(i));
			if (i % 10 == 0) {
				getSession().flush();
				getSession().clear();
			}
			
		}
	}

}