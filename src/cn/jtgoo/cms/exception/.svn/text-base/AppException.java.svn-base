package cn.jtgoo.cms.exception;

public class AppException extends RuntimeException {
	// 错误代码
	private String errorCode; //资源文件中定义代码
	private Object [] args; //填充资源文件中占位信息，如{0},{1}等
	public AppException(String errorCode){
		this.errorCode = errorCode;
	}
	public AppException(String errorCode, Object [] args){
		this.errorCode = errorCode;
		this.args = args;
	}
	
	public AppException(String errorCode, String arg){
		this(errorCode,new Object[]{arg});
	}
	public Object[] getArgs() {
		return args;
	}
	public String getErrorCode() {
		return errorCode;
	}
}
