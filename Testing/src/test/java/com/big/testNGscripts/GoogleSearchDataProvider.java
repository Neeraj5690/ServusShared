//package com.big.testNGscripts;
//
//import org.testng.annotations.DataProvider;
//import org.testng.annotations.Test;
//
//import com.big.pageObjects.GooglePO;
//import com.big.utils.TestReusables;
//
//public class GoogleSearchDataProvider extends TestNGInitiation{
//	
//	
//	
//	@DataProvider(name = "SearchText")
//	  public static Object[][] searchTextValues() {
//	        return new Object[][] { {"Automation"}, {"Cucumber"}};
//	  }
//	 
//	 @Test(groups = { "Smoke" }, dataProvider="SearchText", description="Data provider example") 
//	 public void searchText(String strSearchText) {
//		 GooglePO gp = new GooglePO();
//		 gp.verifyElement();
//			gp.searchtext(strSearchText);
//			gp.getsearchtext();
//	 }
//	 
//	 
//
//}
