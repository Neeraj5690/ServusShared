
Feature: FISSSO | Get Cards
Background:
    * def Baseurl = 'https://fissso-xapi.ca-c1.cloudhub.io/api/v1'
    * def subpath = '/getcards/sso?partyId='
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
   
    # Printing saved data
    * print token
    * print jsonPayload
    * print ContentType
    * print Connection
    * print tokenInvalid
    * print ExpectedResponseTime
    * print Accept
    * print PartyID
    * print PartyIDInvalid
    * print StringPartyID
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
    * def ContentType_L7 = Expected_headers['Get_Cards']['Response Headers']['content-type']
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
  Scenario: 6 Check for response and compare same with layer 7 for valid parameter -[ValidPartyID]
    Given url Baseurl + subpath + PartyID
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    * print 'response:', response
    Then status 200 
  		# Getting Mule Response
    * def MuleResponse_Message = response['messages']
    * print MuleResponse_Message
    * def MuleResponse_IsSuccess = response['isSuccess']
    * print MuleResponse_IsSuccess
    * def MuleResponse_Pan = response['response'][0]['pan']
    * print MuleResponse_Pan
    # Reading L7 saved Response
    * def L7_response_Message = L7_ValidResponse['Get_Cards']['messages']
    * print L7_response_Message
    * def L7_response_IsSuccess = L7_ValidResponse['Get_Cards']['isSuccess']
    * print L7_response_IsSuccess
    * def L7_response_Pan = L7_ValidResponse['Get_Cards']['response'][0]['pan']
    * print L7_response_Pan
    # Matching response data
    * match L7_response_Message == MuleResponse_Message   
    * match L7_response_IsSuccess == MuleResponse_IsSuccess 
    * match L7_response_Pan == MuleResponse_Pan
   
   
    # 7a Invalid PartyIDInvalid
  Scenario: 7a Check for response and compare same with layer 7 for invalid parameter - [PartyIDInvalid]
    Given url Baseurl + subpath + PartyIDInvalid
    #And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    * print 'response:', response
    Then status 200
    # Getting Mule Response
    * def MuleResponse_Message = response['message']
    * print MuleResponse_Message
    * def MuleResponse_IsSuccess = response['isSuccess']
    * print MuleResponse_IsSuccess
    # Reading L7 saved Response
    * print L7_InvalidResponse['Get_Cards']['PartyIDInvalid']
    * def L7Response_Message = L7_InvalidResponse['Get_Cards']['PartyIDInvalid']['message']
    * print L7Response_Message
    * def L7_response_IsSuccess = L7_InvalidResponse['Get_Cards']['PartyIDInvalid']['isSuccess']
    * print L7_response_IsSuccess
    # Matching response data
    * match L7Response_Message == MuleResponse_Message
    * match L7_response_IsSuccess == MuleResponse_IsSuccess
   
    # 7b Invalid StringPartyID
  Scenario: 7b Check for response and compare same with layer 7 for invalid parameter - [StringPartyID]
    Given url Baseurl + subpath + StringPartyID
    #And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    * print 'response:', response
    Then status 200
    # Getting Mule Response
    * def MuleResponse_MessageCode = response['messages'][0]['messageCode']
    * print MuleResponse_MessageCode
    * def MuleResponse_MessageText = response['messages'][0]['messageText']
    * print MuleResponse_MessageText
    * def MuleResponse_IsSuccess = response['isSuccess']
    * print MuleResponse_IsSuccess
    # Reading L7 saved Response
    * print L7_InvalidResponse['Get_Cards']['StringPartyID']
    * def L7Response_MessageCode = L7_InvalidResponse['Get_Cards']['StringPartyID']['messages'][0]['messageCode']
    * print L7Response_MessageCode
    * def L7Response_MessageText = L7_InvalidResponse['Get_Cards']['StringPartyID']['messages'][0]['messageText']
    * print L7Response_MessageText
    * def L7_response_IsSuccess = L7_InvalidResponse['Get_Cards']['StringPartyID']['isSuccess']
    * print L7_response_IsSuccess
    # Matching response data
    * match L7Response_MessageCode == MuleResponse_MessageCode
    * match L7Response_MessageText == MuleResponse_MessageText
  		* match L7_response_IsSuccess == MuleResponse_IsSuccess
     
 		# 8 Invalid Authentication Token
  Scenario: 9 Check for Mule api response with Invalid Authentication Token
    Given url Baseurl + subpath + PartyID
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ tokenInvalid
    When method GET
    * print response
    Then status 401