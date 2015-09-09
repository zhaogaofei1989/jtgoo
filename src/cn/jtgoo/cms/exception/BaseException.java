package cn.jtgoo.cms.exception;

import java.io.Serializable;

public class BaseException extends Exception implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 异常码
	 */
	private int exceptionCode;
	/**
	 * 异常描述信息
	 */
	private String easyMessage;
	

	public BaseException(int code) {
		super();
		this.exceptionCode = code;
	}

	public BaseException(int code, String message) {
		super(message);
		this.exceptionCode = code;
		this.easyMessage = message;
	}

	public int getExceptionCode() {
		return this.exceptionCode;
	}

	public String getExceptionMessage() {
		return this.easyMessage;
	}
}
