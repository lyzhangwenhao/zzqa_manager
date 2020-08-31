package com.zzqa.util;

import java.io.StringReader;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

public class XmlUtil {

	public static Element readXML(String file) {
		try {
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = dbf.newDocumentBuilder();
			Document doc = builder.parse(file);
			Element root = doc.getDocumentElement();
			return root;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static Element readXMLByStr(String str) {
		try {
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = dbf.newDocumentBuilder();
			StringReader sr = new StringReader(str);
			InputSource inputSource = new InputSource(sr);
			Document doc = builder.parse(inputSource);
			Element root = doc.getDocumentElement();
			return root;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String getValue(Element element) {
		if (element != null && element.getFirstChild() != null) {
			return element.getFirstChild().getNodeValue();
		}
		return "";
	}

	public static String getValue(Element element, String name) {
		NodeList nl = element.getElementsByTagName(name);
		if (nl != null) {
			Element e = (Element) nl.item(0);
			if (e != null && e.getFirstChild() != null) {
				return e.getFirstChild().getNodeValue();
			}
		}
		return "";
	}
}
