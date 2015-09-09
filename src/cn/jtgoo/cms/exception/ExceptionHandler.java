package cn.jtgoo.cms.exception;
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
  
import org.apache.commons.logging.Log;  
import org.apache.commons.logging.LogFactory;  
import org.apache.struts.Globals;  
import org.apache.struts.action.ActionForm;  
import org.apache.struts.action.ActionForward;  
import org.apache.struts.action.ActionMapping;  
import org.apache.struts.action.ActionMessage;  
import org.apache.struts.config.ExceptionConfig;  
import org.apache.struts.util.ModuleException;  
public class ExceptionHandler extends org.apache.struts.action.ExceptionHandler {  
    /** 
     * Logger for this class 
     */  
    private static final Log logger = LogFactory.getLog(ExceptionHandler.class);  
  
    /* 
     * (non-Javadoc) 
     */  
    @Override  
    public ActionForward execute(Exception ex, ExceptionConfig config, ActionMapping mapping, ActionForm formInstance, HttpServletRequest request,  
            HttpServletResponse response) throws ServletException {  
        if (logger.isDebugEnabled()) {  
            logger.debug("execute(Exception, ExceptionConfig, ActionMapping, ActionForm, HttpServletRequest, HttpServletResponse) - start");  
        }  
  
        logger.warn("action exception.", ex);  
  
        String f = (String) request.getAttribute("exceptionForward");  
        request.setAttribute("javax.servlet.jsp.jspException", ex);  
  
        ActionForward forward = null;  
        ActionMessage error = null;  
        String property = null;  
  
        // Build the forward from the exception mapping if it exists  
        // or from the form input  
        if (config.getPath() != null) {  
            forward = new ActionForward(config.getPath());  
        } else if (f != null) {  
            forward = f.indexOf(".jsp") == -1 ? mapping.findForward(f) : new ActionForward(f);  
        } else {  
            forward = mapping.getInputForward();  
        }  
  
        // Figure out the error  
        if (ex instanceof ModuleException) {  
            error = ((ModuleException) ex).getActionMessage();  
            property = ((ModuleException) ex).getProperty();  
        } else {  
            error = new ActionMessage(config.getKey(), ex.getMessage());  
            property = error.getKey();  
        }  
  
        this.logException(ex);  
  
        // Store the exception  
        request.setAttribute(Globals.EXCEPTION_KEY, ex);  
        this.storeException(request, property, error, forward, config.getScope());  
  
        if (logger.isDebugEnabled()) {  
            logger.debug("execute(Exception, ExceptionConfig, ActionMapping, ActionForm, HttpServletRequest, HttpServletResponse) - end");  
        }  
        return forward;  
    }  
  
}  