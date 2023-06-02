package com.big.testNGscripts;

import java.io.IOException;

import org.testng.ITestContext;
import org.testng.ITestResult;
import org.testng.Reporter;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.BeforeSuite;
import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.Status;
import com.aventstack.extentreports.markuputils.Markup;
import com.aventstack.extentreports.service.ExtentService;
import com.aventstack.extentreports.service.ExtentTestManager;
import com.big.utils.TestReusables;
import com.big.utils.Utilities;

public class TestNGInitiation {
	Utilities util = new Utilities();
	TestReusables tr = new TestReusables();
	@BeforeMethod(alwaysRun = true)
	public void intiateTest() {
		try {
//			ExtentReports er = new ExtentReports();
			util.intiateBrowser();
			util.launchwebsite(util.getProeprty("URL"));
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
	}
	
	@AfterMethod(alwaysRun = true)
	public void closedBrowser(ITestResult testResult, ITestContext testContext) throws IOException {
		if (testResult.getStatus() == ITestResult.FAILURE) { 
			ExtentTestManager.getTest().addScreenCaptureFromBase64String(tr.takeBase64Screenshot(), "Screenshot");
		}
		util.quitBrowser();
		
	}
	
	@BeforeSuite(alwaysRun = true)
	public void testInfo() {
		try {
			ExtentService.getInstance().setSystemInfo("Application URL", Utilities.getProeprty("URL"));
		ExtentService.getInstance().setSystemInfo("Environment", Utilities.getProeprty("Environment"));
		ExtentService.getInstance().setSystemInfo("Browser", Utilities.getProeprty("Browser"));
	    ExtentService.getInstance().setSystemInfo("OS", System.getProperty("os.name"));
	    ExtentService.getInstance().setSystemInfo("User Name", System.getProperty("user.name"));
	    ExtentService.getInstance().flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
