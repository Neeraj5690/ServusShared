@ignore
Feature: CORE_ISO_XAPI
Background:
    * def Baseurl = 'https://core-iso-xapi.ca-c1.cloudhub.io/api/v1/secure/iso20022/account_detail'
    * def resp = call read('AbGet_Okta_Token.feature')
    * match resp.responseStatus == 200
    * def token = resp.response.access_token
    * def payload = {"document":{"get_account":{"account_query_definition":{"account_criteria":{"new_criteria":{"search_criteria":[{"account_identification":[{"equal":{"other":{"identification":""}}}],"account_owner":{"name":"RAMON WASTE CONSULTANTS"}}]}}},"message_header":{"creation_date_time":"2023-03-03T23:27:46.078Z","message_identification":"C1AWeTCfYQxn","request_type":{"proprietary":{"identification":"INTERAC"}}},"supplementary_data":[{"envelope":{"transaction_type":"B05"}}]}}}
 
  Scenario: Account Details
  	* print "Tokennn ", token
    Given url Baseurl
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer '+ token
    And request payload 
    When method POST
    Then status 200
    * print 'response:', response
    
  
    
  #Scenario: Get Universities list of India
  #	* def query = {country:'India'}
    #Given url BaseUrl
    #And params query
    #When method GET
    #Then status 200
    #* print response
    #* print response[0].name
    #* def jsonObject = response
    #* print jsonObject[0].name
    #And match jsonObject[0].name == 'University of Petroleum and Energy Studies'