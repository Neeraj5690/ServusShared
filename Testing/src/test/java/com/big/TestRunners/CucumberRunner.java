package com.big.TestRunners;

import org.junit.runner.RunWith;
import com.aventstack.extentreports.service.ExtentService;
import com.big.utils.TestReusables;
import com.big.utils.Utilities;

import io.cucumber.junit.Cucumber;
//import io.cucumber.junit.CucumberOptions;
import io.cucumber.testng.CucumberOptions;
import io.cucumber.testng.AbstractTestNGCucumberTests;

@RunWith(Cucumber.class)
@CucumberOptions(plugin = {"pretty","html:target/cucumber.html",
		"com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:"},
features = {"src/test/java/com/big/features/APIfeatures"},
glue={"com.big.stepdef"},
monochrome = true,
tags = "@google", 
dryRun = true
)

public class CucumberRunner extends AbstractTestNGCucumberTests {
	
	
	{
		try {
			ExtentService.getInstance().setSystemInfo("Application URL", Utilities.getProeprty("URL"));
			ExtentService.getInstance().setSystemInfo("Environment", Utilities.getProeprty("Environment"));
			ExtentService.getInstance().setSystemInfo("Browser", Utilities.getProeprty("Browser"));
		    ExtentService.getInstance().setSystemInfo("OS", System.getProperty("os.name"));
		    ExtentService.getInstance().setSystemInfo("User Name", System.getProperty("user.name"));
		} catch (Exception e) {
			
			e.printStackTrace();
		}
    }
  
	
}
