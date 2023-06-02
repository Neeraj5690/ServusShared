package com.big.stepdef;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Properties;

import com.big.utils.TestReusables;
import com.big.utils.Utilities;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;

public class Initiation {
	 
	TestReusables tr = new TestReusables();
	Utilities util = new Utilities();
	@Before()
	public void initiatetest(){
		try {
			util.intiateBrowser();
			util.launchwebsite(util.getProeprty("URL"));
		} catch (IOException e) {
			
			e.printStackTrace();
		}
	}
	
	@After()
	public void teardown(Scenario scenario) throws IOException {
		if(scenario.isFailed()) {
			
			scenario.attach(tr.getByteScreenshot(), "image/png", "Screenshot");
		
		}
		util.quitBrowser();
	}

}
