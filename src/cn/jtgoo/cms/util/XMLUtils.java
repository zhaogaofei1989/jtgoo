package cn.jtgoo.cms.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.util.List;

import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;


/**
 * @author Administrator
 * 
 */
public class XMLUtils {
	private static Logger logger = Logger.getLogger(XMLUtils.class);

	/**
	 * 创建document
	 * 
	 * @return
	 */
	public static Document createXMLDom() {
		Document doc = DocumentHelper.createDocument();
		return doc;
	}

	public static void main(String[] args) {
		try {
		
//			Document document=XMLUtils.readXml(Param.mp4XmlPath);
		} catch (Exception e) {
		
			e.printStackTrace();
		}
	}

	/**
	 * 给文档添加根节点
	 * 
	 * @param elName
	 *            子节点名�?
	 * @param doc
	 *            文档
	 * @return
	 */
	public static Element appendRootElement(String elName, Document doc) {
		Element root = doc.addElement(elName);
		return root;
	}

	/**
	 * 给父节点添加子节�?
	 * 
	 * @param elName
	 *            子节点的名称
	 * @param el
	 *            父节�?
	 * @return
	 */
	public static Element appendChildElement(String elName, Element el) {
		Element sub = el.addElement(elName);
		return sub;
	}

	/**
	 * 添加子节点及其对应的�?
	 * 
	 * @param elName
	 *            子节点的名称
	 * @param value
	 *            子节点的�?
	 * @param el
	 *            父节�?
	 */
	public static void appendChildElement(String elName, String value,
			Element el) {
		Element sub = el.addElement(elName);
		sub.setText(value);
	}

	/**
	 * 
	 * @param element
	 *            节点
	 * @param text
	 *            文本�?
	 */
	public static void setElementText(Element element, String text) {
		element.setText(text);
	}

	/**
	 * 根目录添加注�?
	 * 
	 * @param explain
	 *            说明文字
	 * @param doc
	 */
	public static void addCommend(String explain, Document doc) {
		doc.addComment(explain);
	}

	/**
	 * 为子节点添加说明
	 * 
	 * @param explain
	 * @param element
	 */
	public static void addCommend(String explain, Element element) {
		element.addComment(explain);
	}

	/**
	 * 为节点添加属�?
	 * 
	 * @param attName
	 * @param attValue
	 * @param element
	 */
	public static void addAttribute(String attName, String attValue,
			Element element) {
		element.addAttribute(attName, attValue);
	}

	/**
	 * 以紧凑行格式输出xml文件
	 * 
	 * @param xmlName
	 *            xml文件�?
	 * @param doc
	 *            要写入的document对象
	 * @return
	 */
	public static boolean outXML(String xmlName, Document doc) {
		try {
			/** 将document中的内容写入文件�? */
			XMLWriter writer = new XMLWriter(new FileWriter(new File(xmlName)));
			writer.write(doc);
			writer.close();
			return true;
		} catch (Exception e) {
			logger.debug(e);
			return false;
		}
	}

	/**
	 * 格式化输出xml文件
	 * 
	 * @param xmlName
	 *            xml路径和文件名
	 * @param doc
	 *            要输出的Document
	 * @return
	 */
	public static boolean formatOutXMLFile(String xmlName, Document doc) {
		try {
			XMLWriter writer = null;
			/** 格式化输�?类型IE浏览�?�� */
			OutputFormat format = new OutputFormat("\t", true);  
			/** 指定XML编码 */
			format.setEncoding("GBK");
			writer = new XMLWriter(new FileWriter(new File(xmlName)), format);

			writer.write(doc);
			writer.close();

			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
			return false;
		}
	}

	/**
	 * 该文件无头信息，为wowza定制
	 * 
	 * @param xmlName
	 * @param doc
	 * @return
	 * 
	 * http://hi.baidu.com/douxinchun/item/2a5d48d18d52dacb1a72b4d6
	 * 
	 * 
	 * 
	 */
	public static boolean formatOutXMLFile2(String xmlName, Document doc) {
		try {
			XMLWriter writer = null;
			OutputFormat format = OutputFormat.createPrettyPrint();
			/** 指定XML编码 */
			format.setSuppressDeclaration(true);
			writer = new XMLWriter(new FileOutputStream(new File(xmlName)),
					format);
			writer.write(doc);
			writer.close();

			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
			return false;
		}
	}

	/**
	 * 
	 * @param filepath
	 *            xml文件路径
	 * @return 得到 根元�?
	 */
	public static Element getRootElement(String filepath) {
		// 创建xml解析�?
		SAXReader saxReader = new SAXReader();
		Document doc = null;
		try {
			// 得到要解析的文档
			doc = saxReader.read(XMLUtils.class.getResourceAsStream(filepath));
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		// 得到根元�?
		Element rootElement = doc.getRootElement();
		return rootElement;
	}

	/**
	 * 根据父元素和子元素的名字得到子元素列�?
	 * 
	 * @param element父元�?
	 * @param name子元素的名字
	 * @return 子元素列�?
	 */
	public static List<Element> getElementsByNameAndPElement(Element element,
			String name) {
		return element.elements(name);
	}

	/**
	 * 根据父元素和子元素的名字得到子元�?
	 * 
	 * @param element父元�?
	 * @param name子元素的名字
	 * @return 子元�?
	 */
	public static Element getElementByNameAndPElement(Element element,
			String name) {
		return element.element(name);
	}

	/**
	 * 根据元素和元素的属�?名得到属性�?
	 * 
	 * @param element
	 *            元素
	 * @param param
	 *            属�?�?
	 * @return 属�?�?
	 */
	public static String getElementParamValue(Element element, String param) {
		return element.attributeValue(param);
	}

	/**
	 * 
	 * @param element
	 *            元素�?
	 * @return 元素文本�?
	 */
	public static String getElementText(Element element) {
		return element.getText();
	}

	/**
	 * read xml
	 * 
	 * @throws DocumentException
	 */

	public static Document readXml(String xmlPath) throws DocumentException {

		SAXReader saxReader = new SAXReader();
		  saxReader.setEncoding("GBK");  
		return saxReader.read(xmlPath);

	}

}
