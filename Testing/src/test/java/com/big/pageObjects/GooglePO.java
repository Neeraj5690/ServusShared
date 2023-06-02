package com.big.pageObjects;

import org.junit.Assert;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import com.big.utils.ScenarioContext;
import com.big.utils.TestReusables;
import com.big.utils.Variables;

public class GooglePO extends TestReusables{
	ScenarioContext sc = new ScenarioContext();
//	public GooglePO(RemoteWebDriver driver) {
//		PageFactory.initElements(driver, this);
//	}
	
	public GooglePO() {
		super();
	}

	@FindBy(xpath="//img[@class='lnXdpd']")
	WebElement imgGoogle;
	
	@FindBy(xpath="//input[@title=\"Search\"]")
	WebElement inpSearch;
	
	@FindBy(xpath="//div[@class='FPdoLc lJ9FBc']//input[@class='gNO89b']")
	WebElement btnSearch;
	
	@FindBy(xpath="//input[@class='gLFyf gsfi']")
	WebElement txtSearch;
	
	public void verifyElement() {
		Assert.assertTrue(verifyElement(imgGoogle,"Google Image"));
	
	}
	
	public void searchtext(String strSearchtext) {
		
		  enterText(inpSearch,"Search Textbox", strSearchtext); 
//		  PressSpecialKey(inpSearch,"tab");
//		  keyboardActionsusingRobot(inpSearch, KeyEvent.VK_TAB);
		  keyboardActions(inpSearch,Keys.TAB);
		  click(btnSearch, "Search Button");
		  sc.setContext(Variables.searchText, strSearchtext);
	}
	
	public void getsearchtext() {
		
		Assert.assertEquals(sc.getContext(Variables.searchText),getAttributeValue(txtSearch, "value"));
	}
}
