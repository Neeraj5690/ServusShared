//package com.big.testNGscripts;
//
//import org.testng.annotations.Test;
//import com.big.pageObjects.GooglePO;
//
//
//public class GoogleSearchTest extends TestNGInitiation{
//	
//	@Test (groups = { "Sanity" }, priority=1, description="Search for Testing trends in google")
//	public void searchForTestingTrends() {
//		GooglePO gp = new GooglePO();
//		gp.verifyElement();
//		gp.searchtext("Testing Trends");
//		gp.getsearchtext();
//	}
//	
//	@Test (groups = { "Regression" }, priority=0, description="Search for API Automation in google")
//	public void searchForAPITest() {
//		GooglePO gp = new GooglePO();
//		gp.verifyElement();
//		gp.searchtext("API Automation");
//		gp.getsearchtext();
//	}
//
//}
