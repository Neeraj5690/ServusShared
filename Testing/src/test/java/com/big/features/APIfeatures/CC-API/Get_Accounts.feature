Feature: CC XAPI | Get Accounts
Background:
    * def Baseurl = 'https://credit-card-xapi.ca-c1.cloudhub.io/api/v1'
    * def subpath = '/accounts/'
    # Getting Token Data
    * def resp = call read('GetToken.feature')
    * def token = resp.token
    # Reading Saved Data
    * def jsonPayload = read('SavedData.json')
    * def ContentType = jsonPayload.ContentType
    * def InvalidContentType = jsonPayload.InvalidContentType
    * def Connection = jsonPayload.Connection
    * def Accept = jsonPayload.Accept
    * def tokenInvalid = jsonPayload.InvalidToken
    * def ExpectedResponseTime_Accounts = jsonPayload.ExpectedResponseTime
    * def PartyID = jsonPayload.PartyID
    * def PartyIDInvalid = jsonPayload.PartyIDInvalid
    * def StringPartyID = jsonPayload.StringPartyID
    * def LargePartyID = jsonPayload.LargePartyID
    # Printing saved data
    * print token
    * print jsonPayload
    * print ContentType
    * print Connection
    * print tokenInvalid
    * print ExpectedResponseTime_Accounts
    * print PartyID
    * print Accept
    * print PartyIDInvalid
    * print StringPartyID
    * print LargePartyID
    # Reading Layer 7 Saved Data
    * def L7_ValidResponse = read('Response/valid_response.json')
    * def L7_InvalidResponse = read('Response/Invalid_response.json')
    * def Expected_headers = read('Response/Layer7_header_response.json')
   
   # 1 Mule API response with valid input
  Scenario: 1 Check for Mule API response with valid input
    Given url Baseurl + subpath + PartyID
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   
   # 2 Mule API response with valid request header - [Connection,Accept]
  Scenario: 2 Check for Mule API response with valid request header - [Content-Type]
    Given url Baseurl + subpath + PartyID
    And header Connection = Connection
    And header Accept = Accept
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   
   # 3 Mule API response with Invalid request header - [Content-Type]
  Scenario: 3 Check for Mule API response with Invalid request header - [Content-Type]
    Given url Baseurl + subpath + PartyID
    And header Content-Type = InvalidContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   
   
    # 4 response headers - Content-Length
  Scenario: 4 Check for response headers and its values and compare same with layer 7 - [Content-Length]
    Given url Baseurl + subpath + PartyID
    #And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    * print response
    * print responseHeaders
    Then status 200
    # Getting Mule Response
    * def ContentLength_mule = responseHeaders["Content-Length"][0]
    # Reading L7 saved Response
    * def ContentLength_L7 = Expected_headers['Get_Accounts']['Response Headers']['content-length']
    # Matching response data
    And match ContentLength_L7 == ContentLength_mule
   

    # 5 response headers - Content-Type
  Scenario: 5 Check for response headers and its values and compare same with layer 7 - [Content-Type]
    Given url Baseurl + subpath + PartyID
    #And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    * print response
    Then status 200
    * print responseHeaders
    # Getting Mule Response
    * def ContentType_mule = responseHeaders["Content-Type"][0]
    # Reading L7 saved Response
    * def ContentType_L7 = Expected_headers['Get_Accounts']['Response Headers']['content-type']
    # Matching response data
    And karate.match(ContentType_L7 == ContentType_mule, 'ignoreCase')   
   
    # 6 ResponseTime
  Scenario: 6 Check for responseTime and compare with expected response time - [ResponseTime]
    Given url Baseurl + subpath + PartyID
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    * print response
    Then status 200
    # Getting Mule Response
    * def responseTime = karate.get('responseTime')
    And print responseTime
    # Reading expected saved Response
    * print ExpectedResponseTime_Accounts
    # Matching response data
    * assert responseTime <= ExpectedResponseTime_Accounts


    # 7 Valid PartyID
  Scenario: 7 Check for response and compare same with layer 7 for valid parameter -[PartyID]
    Given url Baseurl + subpath + PartyID
    #And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    * print 'response:', response
    Then status 200
    # Getting Mule Response
    And def Response_mule = response
    * karate.remove('response', 'Timestamp')
    #* karate.remove('response', 'referenceNumber')
    # Reading L7 saved Response
    * def L7_response_data = L7_ValidResponse['Get_Accounts']
    * print L7_response_data
    # Matching response data
    * match L7_response_data == Response_mule   
   
   
    # 8 invalid member number
  Scenario: 8 Check for response and compare same with layer 7 for invalid parameter - [PartyID]
    Given url Baseurl + subpath + PartyIDInvalid
    #And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    * print 'response:', response
    Then status 200
    # Getting Mule Response
    * def MuleResponse_ApiVersionNumber = response['ApiVersionNumber']
    * def MuleResponse_IsSuccess = response['IsSuccess']
    * print MuleResponse_ApiVersionNumber
    * print MuleResponse_IsSuccess
    # Reading L7 saved Response
    * print L7_InvalidResponse
    * def L7Response_ApiVersionNumber = L7_InvalidResponse['InvalidPartyid']['ApiVersionNumber']
    * def L7Response_IsSuccess = L7_InvalidResponse['InvalidPartyid']['IsSuccess']
    * print L7Response_ApiVersionNumber
    * print L7Response_IsSuccess
    # Matching response data
    * match L7Response_ApiVersionNumber == MuleResponse_ApiVersionNumber
    * match L7Response_IsSuccess == MuleResponse_IsSuccess
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
    
  #Scenario: Check for response headers and its values and compare same with layer 7 - [Content-Length]
    #Given url Baseurl + '/accounts/2512'
    #And header Authorization = 'Bearer ' + token
    #When method GET
    #Then status 200
    #* print 'response:', response
#		* def ContentLength_L7 = Expected_headers['Get_Accounts']['Response Headers']['content-length']
    #* def ContentLength_mule = responseHeaders["Content-Length"][0]
    #And match ContentLength_L7 == ContentLength_mule 
    #
  #Scenario: Check for response headers and its values and compare same with layer 7 - [Content-Type] 
    #Given url Baseurl + '/accounts/2512'
    #And header Authorization = 'Bearer ' + token
    #When method GET
    #Then status 200
    #* print 'response:', response
#		* def ContentType_L7 = Expected_headers['Get_Accounts']['Response Headers']['content-type']
    #* def ContentType_mule = responseHeaders["Content-Type"][0]
    #And karate.match(ContentType_L7 == ContentType_mule, 'ignoreCase')
#
#Scenario:  Check for ResponseTime of Get Accounts API and compare same with layer 7 - [ResponseTime] 
    #Given url Baseurl + '/accounts/2512'
    #And header Authorization = 'Bearer ' + token
    #When method GET
    #Then status 200
    #* print response
    #* def responseTime = karate.get('responseTime')
    #And print responseTime 
    #* def Expected_responseTime = 1000 
    #* def Layer7_responseTime = 677
    #* assert responseTime <= Expected_responseTime
#
#	Scenario:  Check for Response and compare same with layer 7-[Response] 
    #Given url Baseurl + '/accounts/2512'
    #And header Authorization = 'Bearer ' + token
    #When method GET
    #Then status 200
    #* print response
    #And def Response_mule = response
    #* karate.remove('response', 'timestamp')
    #* karate.remove('response', 'referenceNumber')
    #* print Response_mule
    #* def L7_response_accounts = Expected_output['Get_Accounts']
    #* karate.match(L7_response == Response_mule, 'ignoreCase')
    #* match L7_response_accounts == Response_mule 









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