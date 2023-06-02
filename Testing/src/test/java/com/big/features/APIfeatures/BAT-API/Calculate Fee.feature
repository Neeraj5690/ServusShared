Feature: BAT | Calculate Fee API
Background:
    * def Baseurl = 'https://bat-xapi.ca-c1.cloudhub.io/api/v1'
    * def jsonPayload = read('request2.json')
    * def Expected_output = read('Response/valid_response.json')
    * def Expected_output2 = read('Response/Invalid_response.json')  
    * def Expected_headers = read('Response/Layer7_header_response.json')
    * def payload2 = {"minimumFee":3,"feePercent":2,"paymentAmounts":[1000]}
    * def resp = call read('GetToken.feature')
    * def token = resp.response.access_token
    
    
  Scenario:  Check for Response  for valid Request and compare with layer 7 for valid payee
    Given url Baseurl + '/calculatefee'
    #And request {"memberNumber": 54320}
    And request jsonPayload
    And header Content-Type = 'application/json'
    * print 'ExpectedHeaders ' + Expected_headers
    * print 'token '+ token
    And header Authorization = 'Bearer '+ token
    When method POST
    Then status 200
    And def Response_mule = response
    * karate.remove('response', 'timestamp')
    * karate.remove('response', 'referenceNumber')
    * print Response_mule
    * def L7_response_Fee = Expected_output['Calculate Fee']
    