package com.big.utils;

import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.time.Duration;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import org.apache.commons.io.FileUtils;
import org.openqa.selenium.Alert;
import org.openqa.selenium.Keys;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.safari.SafariDriver;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;
import org.testng.Reporter;

import com.aventstack.extentreports.Status;
import com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter;
import com.aventstack.extentreports.service.ExtentService;
import com.aventstack.extentreports.service.ExtentTestManager;

//import com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter;
import io.github.bonigarcia.wdm.WebDriverManager;

public class TestReusables {
	
	public static RemoteWebDriver driver;
	public static String testType;
	/*
	 * Map<String, String> mobileEmulation = new HashMap<>(); ChromeOptions
	 * chromeOptions = new ChromeOptions(); protected static
	 * ThreadLocal<RemoteWebDriver> driver = new ThreadLocal<RemoteWebDriver>();
	 */
    public TestReusables() {
    	this.driver = Utilities.getDriver();
    	PageFactory.initElements(driver, this);
    	try {
			testType = Utilities.getProeprty("Execution-Type");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
	public void closeBrowser() {
		try {
		 driver.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void enterText(WebElement ele, String eleName, String text) {
		try {
		WebDriverWait wait = new WebDriverWait(driver,Duration.ofSeconds(30));
		wait.until(ExpectedConditions.visibilityOf(ele));
		ele.clear();
		ele.sendKeys(text);
		if(testType.equalsIgnoreCase("Cucumber"))
		ExtentCucumberAdapter.addTestStepLog("Entered text: \""+text+"\" in "+eleName+" field");
		else
		ExtentTestManager.getTest().log(Status.PASS, "Entered text: \""+text+"\" in "+eleName+" field");
		}
		catch (Exception e) {
			e.printStackTrace();
			if(testType.equalsIgnoreCase("Cucumber"))
				ExtentCucumberAdapter.addTestStepLog("Text: \""+text+"\" not entered in "+eleName+" field");
			else
				ExtentTestManager.getTest().log(Status.FAIL, "Text: \""+text+"\" not entered in "+eleName+" field");
		}
	}

	public void click(WebElement ele, String eleName) {
		try {
		WebDriverWait wait = new WebDriverWait(driver,Duration.ofSeconds(30));
		wait.until(ExpectedConditions.visibilityOf(ele));
		ele.click();
		if(testType.equalsIgnoreCase("Cucumber"))
			ExtentCucumberAdapter.addTestStepLog("Element "+eleName+" clicked");
			else
			ExtentTestManager.getTest().log(Status.PASS, "Element "+eleName+" clicked");
		}
		catch (Exception e) {
			e.printStackTrace();
			if(testType.equalsIgnoreCase("Cucumber"))
				ExtentCucumberAdapter.addTestStepLog("Element "+eleName+" not clicked");
				else
				ExtentTestManager.getTest().log(Status.FAIL, "Element "+eleName+" not clicked");
		}
	}
	
	public void selectByValue(WebElement ele, String eleName, String value) {
		try {
		WebDriverWait wait = new WebDriverWait(driver,Duration.ofSeconds(30));
		wait.until(ExpectedConditions.visibilityOf(ele));
		Select select = new Select(ele);
		select.selectByValue(value);
		if(testType.equalsIgnoreCase("Cucumber"))
		ExtentCucumberAdapter.addTestStepLog("Option "+value+" selected from "+eleName+" Dropdown");
		else
		ExtentTestManager.getTest().log(Status.PASS, "Option "+value+" selected from "+eleName+" Dropdown");
		}
		catch (Exception e) {
			e.printStackTrace();
			if(testType.equalsIgnoreCase("Cucumber"))
			ExtentCucumberAdapter.addTestStepLog("Option "+value+" not selected from "+eleName+" Dropdown");
			else
			ExtentTestManager.getTest().log(Status.FAIL, "Option "+value+" not selected from "+eleName+" Dropdown");
		}
	}
	
	public void selectByText(WebElement ele, String eleName, String value) {
		try {
		WebDriverWait wait = new WebDriverWait(driver,Duration.ofSeconds(30));
		wait.until(ExpectedConditions.visibilityOf(ele));
		Select select = new Select(ele);
		select.selectByVisibleText(value);
		if(testType.equalsIgnoreCase("Cucumber"))
			ExtentCucumberAdapter.addTestStepLog("Option "+value+" selected from "+eleName+" Dropdown");
			else
			ExtentTestManager.getTest().log(Status.PASS, "Option "+value+" selected from "+eleName+" Dropdown");
			
		}
		catch (Exception e) {
			e.printStackTrace();
			if(testType.equalsIgnoreCase("Cucumber"))
				ExtentCucumberAdapter.addTestStepLog("Option "+value+" not selected from "+eleName+" Dropdown");
				else
				ExtentTestManager.getTest().log(Status.FAIL, "Option "+value+" not selected from "+eleName+" Dropdown");
				
		}
	}
	
	public void selectByIndex(WebElement ele, String eleName, int value) {
		try {
		WebDriverWait wait = new WebDriverWait(driver,Duration.ofSeconds(30));
		wait.until(ExpectedConditions.visibilityOf(ele));
		Select select = new Select(ele);
		select.selectByIndex(value);
		if(testType.equalsIgnoreCase("Cucumber"))
			ExtentCucumberAdapter.addTestStepLog("Index "+value+" selected from "+eleName+" Dropdown");
			else
			ExtentTestManager.getTest().log(Status.PASS, "Index "+value+" selected from "+eleName+" Dropdown");
			
		}
		catch (Exception e) {
			e.printStackTrace();
			if(testType.equalsIgnoreCase("Cucumber"))
				ExtentCucumberAdapter.addTestStepLog("Index "+value+" not selected from "+eleName+" Dropdown");
				else
				ExtentTestManager.getTest().log(Status.FAIL, "Index "+value+" not selected from "+eleName+" Dropdown");
				
		}
	}
	
	public boolean verifyElement(WebElement ele, String eleName) {
		try {
		WebDriverWait wait = new WebDriverWait(driver,Duration.ofSeconds(30));
		wait.until(ExpectedConditions.visibilityOf(ele));
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return ele.isDisplayed();
	}
	
	public String getText(WebElement ele) {
		try {
		WebDriverWait wait = new WebDriverWait(driver,Duration.ofSeconds(30));
		wait.until(ExpectedConditions.visibilityOf(ele));
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return ele.getText();
	}
	
	public String getAttributeValue(WebElement ele, String attribute) {
		try {
		WebDriverWait wait = new WebDriverWait(driver,Duration.ofSeconds(30));
		wait.until(ExpectedConditions.visibilityOf(ele));
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return ele.getAttribute(attribute);
	}
	
	public void acceptAlert() {
		try {
			WebDriverWait wait = new WebDriverWait(driver,Duration.ofSeconds(30));
			wait.until(ExpectedConditions.alertIsPresent());
			Alert alert = driver.switchTo().alert();
			alert.accept();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void dismissAlert() {
		try {
			WebDriverWait wait = new WebDriverWait(driver,Duration.ofSeconds(30));
			wait.until(ExpectedConditions.alertIsPresent());
			Alert alert = driver.switchTo().alert();
			alert.dismiss();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getAlertText() {
		String alertText = null;
		try {
			WebDriverWait wait = new WebDriverWait(driver,Duration.ofSeconds(30));
			wait.until(ExpectedConditions.alertIsPresent());
			Alert alert = driver.switchTo().alert();
			alertText = alert.getText();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return alertText;
	}
	
	public void keybordentry(String key) {
		try {
			Robot rb = new Robot();
			if(key.equalsIgnoreCase("Enter")) {
			rb.keyPress(KeyEvent.VK_ENTER);
			rb.keyRelease(KeyEvent.VK_ENTER);
			}
			if(key.equalsIgnoreCase("Tab")) {
				rb.keyPress(KeyEvent.VK_TAB);
				rb.keyRelease(KeyEvent.VK_TAB);
				}
			if(key.equalsIgnoreCase("Down")) {
				rb.keyPress(KeyEvent.VK_DOWN);
				rb.keyRelease(KeyEvent.VK_DOWN);
				}
			if(key.equalsIgnoreCase("Up")) {
				rb.keyPress(KeyEvent.VK_UP);
				rb.keyRelease(KeyEvent.VK_UP);
				}
			if(key.equalsIgnoreCase("Right")) {
				rb.keyPress(KeyEvent.VK_RIGHT);
				rb.keyRelease(KeyEvent.VK_RIGHT);
				}
			if(key.equalsIgnoreCase("Left")) {
				rb.keyPress(KeyEvent.VK_LEFT);
				rb.keyRelease(KeyEvent.VK_LEFT);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void PressSpecialKey(WebElement ele, String key) {
		try {
		WebDriverWait wait = new WebDriverWait(driver,Duration.ofSeconds(30));
		wait.until(ExpectedConditions.visibilityOf(ele));
		if(key.equalsIgnoreCase("Enter"))
		ele.sendKeys(Keys.ENTER);
		if(key.equalsIgnoreCase("Tab"))
			ele.sendKeys(Keys.TAB);
		if(key.equalsIgnoreCase("Down"))
			ele.sendKeys(Keys.DOWN);
		if(key.equalsIgnoreCase("Up"))
			ele.sendKeys(Keys.UP);
		if(key.equalsIgnoreCase("Left"))
			ele.sendKeys(Keys.LEFT);
		if(key.equalsIgnoreCase("Right"))
			ele.sendKeys(Keys.RIGHT);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public byte[] getByteScreenshot() throws IOException 
	{	byte[] fileContent = null;
	    try {
		File src = driver.getScreenshotAs(OutputType.FILE);
	    fileContent = FileUtils.readFileToByteArray(src);
	    return fileContent;
	    }
	    catch(Exception e) {
	    	e.printStackTrace();
	    }
	    return fileContent;
	}
	
	public String takeScreenshot(String name) {
		 try { 
			 String screenshotpath = ""+System.getProperty("user.dir")+"\\test-output\\screenshot";
			 File src = driver.getScreenshotAs(OutputType.FILE);
		     FileUtils.copyFile(src, new File(screenshotpath+"\\"+name+".jpg"));
		     return screenshotpath+"\\"+name+".jpg";
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 return null;
	}
	
	public String takeBase64Screenshot() {
		String screenShotpath = null;
		try {
			screenShotpath = "data:image/png;base64," + driver.getScreenshotAs(OutputType.BASE64);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return screenShotpath;
	}
	
	public void navigateBack() {
		try {
		driver.navigate().back();
		driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void clickUnsingJS(WebElement ele, String eleName) {
		try {
		WebDriverWait wait = new WebDriverWait(driver,Duration.ofSeconds(30));
		wait.until(ExpectedConditions.visibilityOf(ele));
		driver.executeScript("arguments[0].click();", ele);
		if(testType.equalsIgnoreCase("Cucumber"))
			ExtentCucumberAdapter.addTestStepLog("Element "+eleName+" clicked");
			else
			ExtentTestManager.getTest().log(Status.PASS, "Element "+eleName+" clicked");
		}
		catch (Exception e) {
			e.printStackTrace();
			if(testType.equalsIgnoreCase("Cucumber"))
				ExtentCucumberAdapter.addTestStepLog("Element "+eleName+" not clicked");
				else
				ExtentTestManager.getTest().log(Status.FAIL, "Element "+eleName+" not clicked");
		}  
	}
	
	public void dragAndDrop(WebElement ele1, WebElement ele2) {
		try {
		WebDriverWait wait = new WebDriverWait(driver,Duration.ofSeconds(30));
		wait.until(ExpectedConditions.visibilityOf(ele1));
		wait.until(ExpectedConditions.visibilityOf(ele2));
		Actions action = new Actions(driver);
		action.dragAndDrop(ele1, ele2).build().perform();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void movetoElement(WebElement ele) {
		try {
			WebDriverWait wait = new WebDriverWait(driver,Duration.ofSeconds(30));
			wait.until(ExpectedConditions.visibilityOf(ele));
			Actions action = new Actions(driver);
			action.moveToElement(ele).build().perform();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void assertTwoTexts(String expected, String actual) {
		try {
			/*
			 * ExtentCucumberAdapter.addTestStepLog("-->The Expected value:"
			 * +expected+"\n --> The Actual value:"+actual);
			 * if(expected.equalsIgnoreCase(actual))
			 * ExtentCucumberAdapter.addTestStepLog("Expected and Actuals are same"); else
			 ExtentCucumberAdapter.addTestStepLog("Expected and Actuals are not same");*/
			Assert.assertEquals(actual, expected);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void scrolltoElement(WebElement ele) {
		try {
			WebDriverWait wait = new WebDriverWait(driver,Duration.ofSeconds(30));
			wait.until(ExpectedConditions.visibilityOf(ele));
			driver.executeScript("arguments[0].scrollIntoView();", ele);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public Set<String> getWindowHandles() {
		Set<String> handles = new HashSet<String>();
		try {
			handles = driver.getWindowHandles();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return handles;
	}
	
	public String getWindowHandle() {
		String handle = null;
		try {
			handle = driver.getWindowHandle();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return handle;
	}
	
	public void switchToWindow(String winHandle) {
		try {
			driver.switchTo().window(winHandle);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void switchToDefaultWindow(){
		try {
			driver.switchTo().defaultContent();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void switchToFrame(WebElement frame) {
		try {
			driver.switchTo().frame(frame);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void switchToDefaultContent(){
		try {
			driver.switchTo().defaultContent();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void switchToDefaultByClosingChilds() {
		try {
		ArrayList<String> windows = new ArrayList<String>(driver.getWindowHandles());
		int i=0;
		for(String window : windows) {
			if(i!=0) {
				driver.switchTo().window(window).close();
			}
			i++;
		}
		driver.switchTo().window(windows.get(0));
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public void keyboardActions(WebElement ele, Keys key) {
		try {
		WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(30));
		wait.until(ExpectedConditions.visibilityOf(ele));
		ele.sendKeys(key);
		}
		catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	public void keyboardActionsusingRobot(WebElement ele, int key) {
		try {
		WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(30));
		wait.until(ExpectedConditions.visibilityOf(ele));
		Robot rb = new Robot();
		rb.keyPress(key);
		rb.keyRelease(key);
		}
		catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	public void deleteAllCookies() {
		try {
			driver.manage().deleteAllCookies();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	

}
