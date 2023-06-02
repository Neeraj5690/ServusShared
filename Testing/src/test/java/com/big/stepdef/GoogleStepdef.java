package com.big.stepdef;

import java.util.List;

import org.junit.runner.RunWith;

import com.big.pageObjects.GooglePO;
import com.big.utils.TestReusables;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.cucumber.junit.Cucumber;
import io.opentelemetry.exporter.logging.SystemOutLogExporter;

@RunWith(Cucumber.class)
public class GoogleStepdef {
//	GooglePO gpo = new GooglePO(TestReusables.driver);
	GooglePO gpo = new GooglePO();
    @Given("^I am on google page$")
    public void i_am_on_google_page() throws Throwable {
       	System.out.println("You are on google Page");
    	gpo.verifyElement();
    	
    }

    @When("^I search for (.*)$")
    public void i_search_for_testing_trends(String strSearch) throws Throwable {
        System.out.println("You Searched for "+strSearch);
        gpo.searchtext(strSearch);
    }
	
    @Then("^I Should see relavant results$")
    public void i_should_see_relavant_results() throws Throwable {
    	gpo.getsearchtext();
    }
    
    @Given("I am on Google home Page")
    public void i_am_on_google_home_page() throws Throwable {
    	System.out.println("You Are on Google Home Page");
     
    }

    @When("I Search For multiple keywords")
    public void i_search_for_multiple_keywords(DataTable dataTable)throws Throwable {
    	List<String> data = dataTable.asList(String.class);
    	for(String a : data) {
    		System.out.println("The Search Keyword Is: "+a);
    	}
    }

    @Then("I Should see relavant search content")
    public void i_should_see_relavant_search_content() throws Throwable{
        System.out.println("The search Keyword displayed");
    }

}
