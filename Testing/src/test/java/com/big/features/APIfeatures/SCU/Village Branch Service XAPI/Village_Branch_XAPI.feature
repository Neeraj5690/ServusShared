@ignore
Feature: Village Branch Service
Background:
    * def Baseurl = 'https://village-branch-directory-xapi.ca-c1.cloudhub.io/api/v1/'
    
  Scenario: Get Branch By Id
    * def Expected_output = read('Response/Branch_By_ID_response.json')  
    Given url Baseurl + 'branch/1'
    And header Authorization = 'Bearer eyJraWQiOiJPNHIyV1VRdGFFSkJITUVHNDE2dFhfeW9QbG1sTTE5c18zUDJNWnpYU2FnIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULldYRHo3d1RMT1ZoM0I2NTNvbEFBOWQteUdGWU9idTlCTHBRT2lpR3dEVzgiLCJpc3MiOiJodHRwczovL3NlcnZ1cy5va3RhcHJldmlldy5jb20vb2F1dGgyL2F1czFrZmV4eDhsNXhhTE5ZMGg4IiwiYXVkIjoiYXBpOi8vYnJhbmNoZGlyZWN0b3J5LWRldiIsImlhdCI6MTY3Nzc3MjkwMSwiZXhwIjoxNjc3Nzc2NTAxLCJjaWQiOiIwb2Exa2ZleGZxZ2JQbFpaMDBoOCIsInNjcCI6WyJ0ZW1wRGVmYXVsdCJdLCJzdWIiOiIwb2Exa2ZleGZxZ2JQbFpaMDBoOCJ9.1aCQI3uch4ev32Co_5gctH1YD3yHZAQhjQPDcMfpxHFV-3Z9drCccy_d83IdX6ZJRNY4YrFJkqYQcynuHGFVlZuw6BTXbGrUcnTwIT22e9tKlMnPyakLuWjrL_Da01ZbyWnuvMoEP6S6X9VqL8gNVXZSSJr6Iv-LRDm921ibPasEsrHycwxx7JJVMLua2vF-U1RyZS4XYK6eh-81UjwRnimxV4W8JkTO8M237T69beIQkwDtWrEinhM1d2vH0Fxb4ZiGyuWScrLB44RXQ5yxxSRl5gLbGE6s_WSFMeeB3dku_WIfolRaNhJB-FalseNJY4gLX3RkgAuv60GB4nPjkw'
    When method GET
    Then match responseStatus == 200
    And match response.Response.BranchServices[1].ServiceTypeTitle == 'Commercial Services'
    * print 'response:', response
    * karate.match(response, Expected_output)
    And match response contains any Expected_output
    #And match response contains Expected_output
    #And match response == Expected_output
    #And karate.forEach(response,'#[0].BranchService[1])
    
  Scenario: Get List of Branches
  	* def Expected_output = read('Response/List_Branches_response.json')
  	Given url Baseurl + 'branch?branchIds=1&branchIds=2'
    When method GET
    Then status 200
    * print 'response:', response
        
  Scenario: Get Search BranchAtm
  	* def Expected_output = read('Response/Search_Branch_ATM_response.json')
  	Given url Baseurl + 'search/branchatm?search.searchKeyword=atrium'
    When method GET
    Then status 200
    And print 'Resss', response.Response[1]
    #Then match response[1].CityName.equals('Red Deer')
    #* print 'responseHeaders ', responseHeaders
 		* print 'response ', response
 
 
   Scenario: Get List of Atms
   * def Expected_output = read('Response/List_ATMS_response.json')
  	Given url Baseurl + 'atm?search.cityName=Red'
    When method GET
    Then status 200
    * print 'response:', response   
    * print 'City Name ', response.Response[4].CityName
    Then match response.Response[4].CityName contains 'Red'
  	#Then match each response.Response[*].CityName == 'Red Deer'
  
   Scenario: Get ATM By Id
    * def Expected_output = read('Response/ATM_by_id_response.json')
  	Given url Baseurl + 'atm/1'
    When method GET
    Then status 200
    * print 'response:', response  
    
   Scenario: Get ATM with invalid Id
  	Given url Baseurl + 'atm/1009'
    When method GET
    Then status 200
    * print 'response:', response.IsSuccess    
  	Then match response.IsSuccess == false
      
    
    Scenario: Health Check
  	Given url Baseurl + '/healthcheck'
    When method GET
    Then status 200
    * print 'response:', response   
    