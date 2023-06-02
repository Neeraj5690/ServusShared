@ignore
Feature: Read Accounts
Background:
    * def Baseurl = 'https://credit-card-xapi.ca-c1.cloudhub.io/api/v1'
    * def resp = call read('GetToken.feature')
    * def token = resp.response.access_token
    
  Scenario: Get Accounts
  	* def Expected_output = read('Response/Get_accounts_Response.json')
    Given url Baseurl + '/accounts/2512'
    And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    * print 'response:', response
    And match response == Expected_output
    
  Scenario: Get Details w/o real-time
  	* def Expected_output = read('Response/Get_details1.json')
  	Given url Baseurl + '/account/5900001228827406/detail?resolution=None'
    And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    * print 'response:', response
    And match response == Expected_output
        
  Scenario: Get Details w/real-time
  	* def Expected_output = read('Response/Get_details2.json')
  	Given url Baseurl + '/account/5900001228827406/detail?resolution=None'
    And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    * print 'response:', response      
 		And match response == Expected_output
 		
   Scenario: Get Transactions
   	* def Expected_output = read('Response/Get_transactions_response.json')
  	Given url Baseurl + '/account/5500003368564098/transactions'
    And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    * print 'response:', response      
 		And match response == Expected_output
 		 
   Scenario: Get Health Check
  	Given url Baseurl + '/healthcheck'
    When method GET
    Then status 200
    * print 'response:', response  