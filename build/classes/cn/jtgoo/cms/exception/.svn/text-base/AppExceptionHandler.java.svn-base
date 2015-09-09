package cn.jtgoo.cms.exception;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.Globals;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.config.ExceptionConfig;

public class AppExceptionHandler extends ExceptionHandler {
	public ActionForward execute(Exception ex, ExceptionConfig ae, 

	ActionMapping mapping, ActionForm formInstance, HttpServletRequest request, 

	HttpServletResponse response) throws ServletException {
		if(!(ex instanceof AppException)) 
		{
		return super.execute(ex, ae, mapping, formInstance, request, response);
		}
		 ActionForward forward = null;
		 ActionMessage error = null;
		 String property = null;
		 //获取异常处理路径,从exception mapping或者从form input
		 if (ae.getPath() != null) {
				forward = new ActionForward(ae.getPath());
		 } else {
				forward = mapping.getInputForward();
		 } 
		 //处理异常
		 AppException ece =(AppException) ex;
		 String errorCode =ece.getErrorCode();
		 error = new ActionMessage(errorCode, ece.getArgs());
		 property = error.getKey();
		 logException(ex);
		 //记录异常
		 request.setAttribute(Globals.EXCEPTION_KEY, ex);
		 storeException(request, property, error, forward, ae.getScope());
		return forward;
	}
	}