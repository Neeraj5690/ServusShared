
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
    * def ExpectedResponseTime = jsonPayload.ExpectedResponseTime_Accounts
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
    * print ExpectedResponseTime
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

    # 4 response headers - Content-Type
  Scenario: 4 Check for response headers and its values and compare same with layer 7 - [Content-Type]
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
   
    # 5 ResponseTime
  Scenario: 5 Check for responseTime and compare with expected response time - [ResponseTime]
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
    * print ExpectedResponseTime
    # Matching response data
    * assert responseTime <= ExpectedResponseTime


    # 6 Valid PartyID
  Scenario: 6 Check for response and compare same with layer 7 for valid parameter -[PartyID]
    Given url Baseurl + subpath + PartyID
    And header Content-Type = ContentType
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
   
   
    # 7 invalid PartyID
  Scenario: 7 Check for response and compare same with layer 7 for invalid parameter - [PartyID]
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
    * def L7Response_ApiVersionNumber = L7_InvalidResponse['GetAccounts']['InvalidPartyid']['ApiVersionNumber']
    * def L7Response_IsSuccess = L7_InvalidResponse['GetAccounts']['InvalidPartyid']['IsSuccess']
    * print L7Response_ApiVersionNumber
    * print L7Response_IsSuccess
    # Matching response data
    * match L7Response_ApiVersionNumber == MuleResponse_ApiVersionNumber
    * match L7Response_IsSuccess == MuleResponse_IsSuccess
   
 		# 8 Invalid Authentication Token
  Scenario: 8 Check for Mule api response with Invalid Authentication Token
    Given url Baseurl + subpath + PartyIDInvalid
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ tokenInvalid
    When method GET
    * print response
    Then status 401
 