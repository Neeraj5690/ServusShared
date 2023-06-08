@ignore
Feature: Get PAN Details API
Background:
    * def Baseurl = 'https://village-branch-directory-xapi.ca-c1.cloudhub.io/api/v1'
    * def subpath = '/branch?branchIds=1'
    #* def resp = call read('GetToken.feature')
    * def Expected_output = read('Response/valid_response.json')
    * def token = resp.response.access_token
    * def Expected_headers = read('Response/Layer7_header_response.json')
    
  Scenario: Check for response headers and its values and compare same with layer 7 - [Content-Length]
    Given url Baseurl + subpath
    #And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    * print 'response:', response
		* def ContentLength_L7 = Expected_headers['Get_pan_Details']['Response Headers']['content-length']
    * def ContentLength_mule = responseHeaders["Content-Length"][0]
    And match ContentLength_L7 == ContentLength_mule 
    
  Scenario: Check for response headers and its values and compare same with layer 7 - [Content-Type] 
    Given url Baseurl + subpath
    
    #And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    * print 'response:', response
		* def ContentType_L7 = Expected_headers['Get_pan_Details']['Response Headers']['content-type']
    * def ContentType_mule = responseHeaders["Content-Type"][0]
    And match ContentLength_L7 == ContentLength_mule 

Scenario:  Check for ResponseTime of Get Accounts API and compare same with layer 7 - [ResponseTime] 
    Given url Baseurl + subpath
    
    #And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    * print response
    * def responseTime = karate.get('responseTime')
    And print responseTime 
    * def Expected_responseTime = 1000 
    * def Layer7_responseTime = 677
    * assert responseTime <= Expected_responseTime

	Scenario:  Check for Response and compare same with layer 7-[Response] 
    Given url Baseurl + '/account/5900001228827406/detail?resolution=None'
    #And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    * print response
    And def Response_mule = response
    * karate.remove('response', 'timestamp')
    * karate.remove('response', 'referenceNumber')
    * print Response_mule
    * def L7_response_accounts = L7_response['Get_Accounts']

    * karate.match(L7_response == Response_mule, 'ignoreCase')
    * match L7_response_accounts == Response_mule 



  #Scenario: Get Details w/o real-time
  #	* def Expected_output = read('Response/Get_details1.json')
  #	Given url Baseurl + '/account/5900001228827406/detail?resolution=None'
    #And header Authorization = 'Bearer ' + token
    #When method GET
    #Then status 200
    #* print 'response:', response
    #And match response == Expected_output
        #
  #Scenario: Get Details w/real-time
  #	* def Expected_output = read('Response/Get_details2.json')
  #	Given url Baseurl + '/account/5900001228827406/detail?resolution=None'
    #And header Authorization = 'Bearer ' + token
    #When method GET
    #Then status 200
    #* print 'response:', response      
 #		And match response == Expected_output
 #		
   #Scenario: Get Transactions
   #	* def Expected_output = read('Response/Get_transactions_response.json')
  #	Given url Baseurl + '/account/5500003368564098/transactions'
    #And header Authorization = 'Bearer ' + token
    #When method GET
    #Then status 200
    #* print 'response:', response      
 #		And match response == Expected_output
 #		 
   #Scenario: Get Health Check
  #	Given url Baseurl + '/healthcheck'
    #When method GET
    #Then status 200
    #* print 'response:', response  