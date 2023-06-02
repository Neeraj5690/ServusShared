package com.big.TestRunners;


import java.util.ArrayList;
import java.util.List;
import org.junit.runner.JUnitCore;
import org.testng.TestNG;
import com.big.utils.Utilities;

public class TestRunner {

	public static void main(String[] args) {
		
		try {
			Utilities util = new Utilities();
			String mode = Utilities.getProeprty("Execution-Type");
			TestNG testNG = new TestNG();
			if(mode.equalsIgnoreCase("Cucumber")) {
				/*Path path = FileSystems.getDefault().getPath("./test-output");
		        try {
		            Files.deleteIfExists(path);
		        }
		        catch(Exception e) {
		        	e.printStackTrace();
		        }*/
				testNG.setTestClasses(new Class[] {CucumberRunner.class});
				testNG.run();
			}
			else if (mode.equalsIgnoreCase("TestNg")) {
				util.builTestNgXML();
				
				  List<String> suites = new ArrayList<String>();
				  suites.add(""+System.getProperty("user.dir")+"\\testng.xml");
				  testNG.setTestSuites(suites); testNG.run();
				 	 
			}
			else {
				JUnitCore junit = new JUnitCore();
			    junit.run(KarateRunner.class);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}