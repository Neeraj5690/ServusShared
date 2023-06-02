package com.big.utils;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.safari.SafariDriver;
import org.testng.collections.Lists;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import io.github.bonigarcia.wdm.WebDriverManager;
import io.restassured.RestAssured;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

public class Utilities {
	Map<String, String> mobileEmulation = new HashMap<>();
    ChromeOptions chromeOptions = new ChromeOptions();
    
    protected static ThreadLocal<RemoteWebDriver> driver = new ThreadLocal<RemoteWebDriver>();
	public void intiateBrowser() throws IOException {
		try {
		String browser = getProeprty("Browser");
		switch(browser){
		case "Chrome":
			WebDriverManager.chromedriver().setup();
			chromeOptions.addArguments("--remote-allow-origins=*");
			driver.set(new ChromeDriver(chromeOptions));
			break;
		case "Firefox":
			WebDriverManager.firefoxdriver().setup();
			driver.set(new FirefoxDriver());
			break;
		case "Edge":
			WebDriverManager.edgedriver().setup();
			driver.set(new EdgeDriver());
			break;
		case "Safari":
			WebDriverManager.safaridriver().setup();
			driver.set(new SafariDriver());
			break;
		case "Android":
			WebDriverManager.chromedriver().setup();
			mobileEmulation.put("deviceName", getProeprty("DeviceName"));
            chromeOptions.setExperimentalOption("mobileEmulation", mobileEmulation);
			driver.set(new ChromeDriver(chromeOptions));
			
			break;
		case "IOS":
			WebDriverManager.chromedriver().setup();
			mobileEmulation.put("deviceName", getProeprty("DeviceName"));
            chromeOptions.setExperimentalOption("mobileEmulation", mobileEmulation);
			driver.set(new ChromeDriver(chromeOptions));
			break;
		}
			driver.get().manage().deleteAllCookies();
			driver.get().manage().window().maximize();
			driver.get().manage().timeouts().implicitlyWait(Duration.ofSeconds(10));
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static RemoteWebDriver getDriver() {
		return driver.get();
	}
	
	
	
	public void launchwebsite(String url) {
		try{
			driver.get().get(url);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void quitBrowser() {
		try {
			driver.get().quit();
//			driver.remove();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static String getProeprty(String strProp) throws IOException {
		String property = null;
		try {
			FileReader reader = new FileReader("config.properties");
	        Properties prop = new Properties();
	        prop.load(reader);
	        property = prop.getProperty(strProp);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return property;
	}
	
	public ResultSet getOracleResultSet(String userName, String passWord, String query) {
		ResultSet rs = null;
		try{  
			Class.forName("oracle.jdbc.driver.OracleDriver");  
			Connection con=DriverManager.getConnection(  
//					@servername:port:databaseName
			"jdbc:oracle:thin:@localhost:1521:bigdb",userName,passWord);  
			Statement stmt=con.createStatement();  
			rs =stmt.executeQuery(query);  
			con.close();  
			
			}
		catch(Exception e)
			{ System.out.println(e);}
		return rs;  
	}
	
	public ResultSet getMySqlResultSet(String userName, String passWord, String query) {
		ResultSet rs = null;
		try{  
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection(  
//					servername:port/databaseName
			"jdbc:mysql://localhost:3306/bigdb",userName,passWord);  
			Statement stmt=con.createStatement();  
			rs =stmt.executeQuery(query);  
			con.close();  
			
			}
		catch(Exception e)
			{ System.out.println(e);}
		return rs;  
	}
	
	public ResultSet getPostgresResultSet(String userName, String passWord, String query) {
		ResultSet rs = null;
		try{  
			Class.forName("org.postgresql.Driver");  
			Connection con=DriverManager.getConnection(  
//					databasesserver/databseName
			"jdbc:postgresql://localhost/bigdb?user="+userName+"&password="+passWord);  
			Statement stmt=con.createStatement();  
			rs =stmt.executeQuery(query);  
			con.close();  
			
			}
		catch(Exception e)
			{ System.out.println(e);}
		return rs;  
	}
	
	public String getJSONNodeValue(String baseURI, String queryURI, String nodePath) {
		RestAssured.baseURI=baseURI; 
		RequestSpecification httpRequest = RestAssured.given();
	        httpRequest.header("X-Client", "testuser")
	       	        .header("Content-Type", "application/json");
	    Response response = httpRequest.get("/"+queryURI);
	    String ResString= response.asString();
	    String nodevalue = JsonPath.with(ResString).get(nodePath).toString();
        return nodevalue;
        
	}
	
	public String getCellValue(String Sheetname, String testName, String colName) {
		String cellValue = null;
		try {
		FileInputStream fis = new FileInputStream(""+System.getProperty("user.dir")+"\\TestData.xlsx");
		Workbook wb = new XSSFWorkbook(fis);
		Sheet ws = wb.getSheet(Sheetname);
		for (int i=0;i<=ws.getLastRowNum();i++) {
			if(ws.getRow(i).getCell(0).getStringCellValue().equalsIgnoreCase(testName)) {
				for(int j=0; j<=ws.getRow(i).getLastCellNum(); j++) {
					if(ws.getRow(0).getCell(j).getStringCellValue().equalsIgnoreCase(colName)) {
						cellValue=ws.getRow(i).getCell(j).getStringCellValue();
						break;
					}
				} 
				break;
			}
		}
		
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return cellValue;
	}
	
	public HashMap<String, String> getTestNgPropsData(){
		HashMap<String, String> testNgClasslist = new HashMap<String, String>();
		try {
		FileInputStream fis = new FileInputStream(""+System.getProperty("user.dir")+"\\TestNGxmlConfig.xlsx");
		Workbook wb = new XSSFWorkbook(fis);
		Sheet ws = wb.getSheet("TestNgProps");
			for(int i=0; i<=ws.getLastRowNum();i++) {
				testNgClasslist.put(ws.getRow(i).getCell(0).getStringCellValue(), ws.getRow(i).getCell(1).getStringCellValue());
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return testNgClasslist;
		
	}
	public HashMap<String, String> getTestNgGroupsdata(){
		HashMap<String, String> testNgClasslist = new HashMap<String, String>();
		try {
		FileInputStream fis = new FileInputStream(""+System.getProperty("user.dir")+"\\TestNGxmlConfig.xlsx");
		Workbook wb = new XSSFWorkbook(fis);
		Sheet ws = wb.getSheet("Groups");
			for(int i=1; i<=ws.getLastRowNum();i++) {
				testNgClasslist.put(ws.getRow(i).getCell(0).getStringCellValue(), ws.getRow(i).getCell(1).getStringCellValue());
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return testNgClasslist;
		
	}
	
	public HashMap<String, ArrayList<String>> getTestNgTestsdata(){
		HashMap<String, ArrayList<String>> testNgClasslist = new HashMap<String, ArrayList<String>>();
		
		try {
		FileInputStream fis = new FileInputStream(""+System.getProperty("user.dir")+"\\TestNGxmlConfig.xlsx");
		Workbook wb = new XSSFWorkbook(fis);
		Sheet ws = wb.getSheet("Classes");
//		System.out.println(ws.getLastRowNum());
			for(int i=1; i<=ws.getLastRowNum();i++) {
				ArrayList<String> classnames = new ArrayList<String>();
				for(int j=1;j<ws.getRow(i).getLastCellNum();j++) {
//					System.out.println(ws.getRow(i).getLastCellNum());
					classnames.add(ws.getRow(i).getCell(j).getStringCellValue());
					
				}
			testNgClasslist.put(ws.getRow(i).getCell(0).getStringCellValue(), classnames);		
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return testNgClasslist;
		
	}
	
	public void builTestNgXML() {
		HashMap<String, String> props = new HashMap<String, String>();
		HashMap<String, String> groups = new HashMap<String, String>();
		HashMap<String, ArrayList<String>> classes = new HashMap<String, ArrayList<String>>();
		try {
		props = getTestNgPropsData();
		groups = getTestNgGroupsdata();
		classes = getTestNgTestsdata();
		DocumentBuilderFactory dfact = DocumentBuilderFactory.newInstance();
		DocumentBuilder dbuild = dfact.newDocumentBuilder();
		Document doc = dbuild.newDocument();
		Element root = doc.createElement("suite");
		doc.appendChild(root);
		root.setAttribute("name", props.get("SuiteName"));
		if(props.get("Parallel").equalsIgnoreCase("Yes")) {
//			 && props.get("ParallelType").equalsIgnoreCase("Tests")
			root.setAttribute("parallel", props.get("ParallelType").toLowerCase());
			root.setAttribute("thread-count", props.get("ThreadCount"));
			}
		Element listeners = doc.createElement("listeners");
		root.appendChild(listeners);
		Element reportListener = doc.createElement("listener");
		listeners.appendChild(reportListener);
		reportListener.setAttribute("class-name", "com.aventstack.extentreports.testng.listener.ExtentITestListenerAdapter");
		Element retryListener = doc.createElement("listener");
		listeners.appendChild(retryListener);
		retryListener.setAttribute("class-name", "com.big.utils.AnnotationTransformer");
		if(groups.size()>0) {
			Element group = doc.createElement("groups");
			root.appendChild(group);
			Element run = doc.createElement("run");
			group.appendChild(run);
			for(Map.Entry grp : groups.entrySet()) {
				if(grp.getValue().toString().equalsIgnoreCase("No")) {
					Element exclude = doc.createElement("exclude");
					run.appendChild(exclude);
					exclude.setAttribute("name", grp.getKey().toString());
					}
				else{
				Element include = doc.createElement("include");
				run.appendChild(include);
				include.setAttribute("name", grp.getKey().toString());
				}
			}
		}
		if(classes.size()>0) {
			for(Map.Entry m:classes.entrySet()) {
				Element test = doc.createElement("test");
				root.appendChild(test);
				test.setAttribute("name", m.getKey().toString());
				/*
				 * if(props.get("Parallel").equalsIgnoreCase("Yes") &&
				 * !props.get("ParallelType").equalsIgnoreCase("Tests")) {
				 * test.setAttribute("parallel",props.get("ParallelType").toLowerCase());
				 * test.setAttribute("thread-count", props.get("ThreadCount")); }
				 */
				Element rootClass = doc.createElement("classes");
				test.appendChild(rootClass);
				for(String classname:(Collection<? extends String>)m.getValue())  {
					Element nameclass = doc.createElement("class");
					rootClass.appendChild(nameclass);
					nameclass.setAttribute("name", "com.big.testNGscripts."+classname);
				}
			}
		} 
		FileOutputStream output = new FileOutputStream(""+System.getProperty("user.dir")+"\\testng.xml");
		TransformerFactory transformerFactory = TransformerFactory.newInstance();
	    Transformer transformer = transformerFactory.newTransformer();
	    transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        DOMSource source = new DOMSource(doc);
	    StreamResult result = new StreamResult(output);
        transformer.transform(source, result);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
}
