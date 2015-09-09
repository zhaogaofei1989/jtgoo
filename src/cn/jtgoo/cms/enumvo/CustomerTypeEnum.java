package cn.jtgoo.cms.enumvo;

/**
 * @author Administrator
 *定义客户类型
 * 用户类型 0代表同业用户 1代表直接用户
 * 同业用户就是旅行社或同行，就是和我们一个行业的公司或个人
 * 直接接用户包括前台注册的会员和直接给我们做生意的人员，这个直接给我们做生意的有可能没在前台网站注册
 * 会员就是通过网站前台注册的用户
 */
public enum CustomerTypeEnum {
	//同业用户类型
	PEER_USER_TYPE,
	//直接用户类型
	DIRECT_USER_TYPE,
	//会员用户类型
	MEMBER_USER_TYPE,

}
