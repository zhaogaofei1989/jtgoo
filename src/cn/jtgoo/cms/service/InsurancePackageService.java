package cn.jtgoo.cms.service;

import java.util.List;

import cn.jtgoo.cms.base.BaseDao;
import cn.jtgoo.cms.domain.InsurancePackage;
public interface InsurancePackageService extends BaseDao<InsurancePackage> {
	
	
	/**根据保险公司 查询出该保险公司下的所有产品
	 * @param id
	 * @return
	 */
	List<InsurancePackage> findByInsuranceTypeId(Long id);
}
