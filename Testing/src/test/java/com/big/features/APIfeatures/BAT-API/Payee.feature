Feature: BAT | Payee
Background:
    * def Baseurl = 'https://bat-xapi.ca-c1.cloudhub.io/api/v1'
    * def jsonPayload = read('request1.json')
    * def Expected_output = read('Response/valid_response.json')
    * def Expected_output2 = read('Response/Invalid_response.json')  
    * def Expected_headers = read('Response/Layer7_header_response.json')
    * def payload2 = {"minimumFee":3,"feePercent":2,"paymentAmounts":[1000]}
    * def resp = call read('GetToken.feature')
    * def token = resp.response.access_token
  
	Scenario:  Check for response headers and its values and compare same with layer7-[Content-Length] 
    Given url Baseurl +'/payees'
    And request jsonPayload
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer ' + token
    And form field client_id = '2c1fe860-ab8f-11e8-98d0-529269fb1459'
    And form field client_secret = '2c1fe860-ab8f-11e8-98d0-529269fb1459'
    And form field x-transaction-id = '2c1fe860-ab8f-11e8-98d0-529269fb1459'
    When method POST
    Then status 200
    * print 'response:', response
    * def ContentLength_L7 = Expected_headers['payee']['Response Headers']['content-length']
    #* def ContentType_L7 = Expected_headers['payee']['Response Headers']['content-type']
    And match ContentLength_L7 == responseHeaders["Content-Length"][0] 
       
	Scenario:  Check for response headers and its values and compare same with layer7-[Content-Type] 
    Given url Baseurl + '/payees'
    And request jsonPayload
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer ' + token
    And form field client_id = '2c1fe860-ab8f-11e8-98d0-529269fb1459'
    And form field client_secret = '2c1fe860-ab8f-11e8-98d0-529269fb1459'
    And form field x-transaction-id = '2c1fe860-ab8f-11e8-98d0-529269fb1459'
    When method POST
    Then status 200
    * print 'response:', response
    * print responseHeaders
    * def ContentType_L7 = Expected_headers['payee']['Response Headers']['content-type'] 
		* def ContentType_mule = responseHeaders["Content-Type"][0]
		And karate.match(ContentType_L7 == ContentType_mule, 'ignoreCase')

#	@ignore
  Scenario: member with invalid Member number[54320123]
    Given url Baseurl + '/member'
    And request {"memberNumber": 54320123}
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer '+ token
    When method POST
    Then status 201
    * print 'response:', response
    
    * def ContentLength_L7 = Expected_headers['Member']['Response Headers']['content-length']
    * def ContentType_L7 = Expected_headers['Member']['Response Headers']['content-type']
    And match ContentLength_L7 == responseHeaders["Content-Length"][0] 
		* def ContentType2 = responseHeaders["Content-Type"][0]
		And match ContentType_L7 == ContentType2 ignoreCase
		
  Scenario: payees
    Given url Baseurl + '/payees'
    And request jsonPayload
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer ' + token
    And form field client_id = '2c1fe860-ab8f-11e8-98d0-529269fb1459'
    And form field client_secret = '2c1fe860-ab8f-11e8-98d0-529269fb1459'
    And form field x-transaction-id = '2c1fe860-ab8f-11e8-98d0-529269fb1459'
    When method POST
    Then status 200
    * print 'response:', response
    * def ContentLength_L7 = Expected_headers['payee']['Response Headers']['content-length']
    * def ContentType_L7 = Expected_headers['payee']['Response Headers']['content-type']
    And match ContentLength_L7 == responseHeaders["Content-Length"][0] 
		* def ContentType2 = responseHeaders["Content-Type"][0]
		And match ContentType_L7 == ContentType2








  #Scenario: Calculate Fee
    #Given url Baseurl + '/calculatefee'
    #And request payload2
    #And header Content-Type = 'application/json'
    #And header Authorization = 'Bearer ' + token
    #When method POST
    #Then status 200
    #* print 'response:', response
    #* def ContentLength_L7 = Expected_headers['calculate']['Response Headers']['content-length']
    #* def ContentType_L7 = Expected_headers['calculate']['Response Headers']['content-type']
    #And match ContentLength_L7 == responseHeaders["Content-Length"][0] 
#		* def ContentType2 = responseHeaders["Content-Type"][0]
#		And match ContentType_L7 == ContentType2
    
 
 
 
 
 
 
 
 
 
  #Scenario: Healthcheck
  #	Given url Baseurl + '/healthcheck'
    #When method GET
    #Then status 200
    #* print 'response:', response
       #* def ContentLength_L7 = Expected_headers['Healthcheck']['Response Headers']['content-length']
    #* def ContentType_L7 = Expected_headers['Healthcheck']['Response Headers']['content-type']
    #And match ContentLength_L7 == responseHeaders["Content-Length"][0] 
#		* def ContentType2 = responseHeaders["Content-Type"][0]
#		And match ContentType_L7 == ContentType2