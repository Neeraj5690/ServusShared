
Feature: FISSSO | Get SSO Token
Background:
    * def Baseurl = 'https://fissso-xapi.ca-c1.cloudhub.io/api/v1'
    * def subpath = '/ssotoken'
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
    * def ccNumberValid = jsonPayload.ccNumberValid
    * def ccNumberInvalid = jsonPayload.ccNumberInvalid
    * def ccNumberString = jsonPayload.ccNumberString
   	* def email = jsonPayload.email
   	* def InvalidEmail = jsonPayload.InvalidEmail
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
    * print ccNumberValid
    * print ccNumberInvalid
    * print ccNumberString
    * print email
    * print InvalidEmail
    # Reading Layer 7 Saved Data
    * def L7_ValidResponse = read('Response/valid_response.json')
    * def L7_InvalidResponse = read('Response/Invalid_response.json')
    * def Expected_headers = read('Response/Layer7_header_response.json')
   
   # 1 Mule API response with valid input
  Scenario: 1 Check for Mule API response with valid input
    Given url Baseurl + subpath  
    And param partyId = PartyID
    And param ccNumber = ccNumberValid
    And param email = email
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   
   # 2 Mule API response with valid request header - [Connection,Accept]
  Scenario: 2 Check for Mule API response with valid request header - [Content-Type]
    Given url Baseurl + subpath  
    And param partyId = PartyID
    And param ccNumber = ccNumberValid
    And param email = email
    And header Connection = Connection
    And header Accept = Accept
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   
   # 3 Mule API response with Invalid request header - [Content-Type]
  Scenario: 3 Check for Mule API response with Invalid request header - [Content-Type]
    Given url Baseurl + subpath  
    And param partyId = PartyID
    And param ccNumber = ccNumberValid
    And param email = email
    And header Content-Type = InvalidContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200

    # 4 response headers - Content-Type
  Scenario: 4 Check for response headers and its values and compare same with layer 7 - [Content-Type]
    Given url Baseurl + subpath  
    And param partyId = PartyID
    And param ccNumber = ccNumberValid
    And param email = email
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
    Given url Baseurl + subpath  
    And param partyId = PartyID
    And param ccNumber = ccNumberValid
    And param email = email
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

  # 6 Valid PartyID, ccNumber, and email
  Scenario: 6 Check for response and compare same with layer 7 for valid parameter -[PartyID, ccNumber, and email]
    Given url Baseurl + subpath  
    And param partyId = PartyID
    And param ccNumber = ccNumberValid
    And param email = email
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
    # Reading L7 saved Response
    * def L7_response_Message = L7_ValidResponse['Get_SSO_Token']['messages']
    * print L7_response_Message
    * def L7_response_IsSuccess = L7_ValidResponse['Get_SSO_Token']['isSuccess']
    * print L7_response_IsSuccess
    # Matching response data
    * match L7_response_Message == MuleResponse_Message   
    * match L7_response_IsSuccess == MuleResponse_IsSuccess
   
   
    # 7a Invalid PartyIDInvalid with valid ccNumber, and email
  Scenario: 7a Check for response and compare same with layer 7 for invalid parameter - [PartyIDInvalid]
    Given url Baseurl + subpath  
    And param partyId = PartyIDInvalid
    And param ccNumber = ccNumberValid
    And param email = email
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
    * print L7_InvalidResponse['Get_SSO_Token']['PartyIDInvalid']
    * def L7Response_MessageCode = L7_InvalidResponse['Get_SSO_Token']['PartyIDInvalid']['messages'][0]['messageCode']
    * print L7Response_MessageCode
    * def L7Response_MessageText = L7_InvalidResponse['Get_SSO_Token']['PartyIDInvalid']['messages'][0]['messageText']
    * print L7Response_MessageText
    * def L7_response_IsSuccess = L7_InvalidResponse['Get_SSO_Token']['PartyIDInvalid']['isSuccess']
    * print L7_response_IsSuccess
    # Matching response data
    * match L7Response_MessageCode == MuleResponse_MessageCode
    * match L7Response_MessageText == MuleResponse_MessageText
  		* match L7_response_IsSuccess == MuleResponse_IsSuccess

    # 7b Valid PartyID, and email with Invalid ccNumber
  Scenario: 7b Check for response and compare same with layer 7 for invalid parameter - [ccNumberInvalid]
    Given url Baseurl + subpath  
    And param partyId = PartyID
    And param ccNumber = ccNumberInvalid
    And param email = email
    And header Authorization = 'Bearer '+ token
    When method GET
    * print 'response:', response
    Then status 500
    # Getting Mule Response
    * def MuleResponse_StatusCode = response['StatusCode']
    * print MuleResponse_StatusCode
    * def MuleResponse_MessageText = response['Message']
    * print MuleResponse_MessageText
    # Reading L7 saved Response
    * print L7_InvalidResponse['Get_SSO_Token']['ccNumberInvalid']
    * def L7Response_StatusCode = L7_InvalidResponse['Get_SSO_Token']['ccNumberInvalid']['StatusCode']
    * print L7Response_StatusCode
    * def L7Response_MessageText = L7_InvalidResponse['Get_SSO_Token']['ccNumberInvalid']['Message']
    * print L7Response_MessageText
    # Matching response data
    * match L7Response_StatusCode == MuleResponse_StatusCode
    * match L7Response_MessageText == MuleResponse_MessageText
     
    # 7c Valid PartyID, and email with Invalid ccNumberString
  Scenario: 7c Check for response and compare same with layer 7 for invalid parameter - [ccNumberString]
    Given url Baseurl + subpath  
    And param partyId = PartyID
    And param ccNumber = ccNumberString
    And param email = email
    And header Authorization = 'Bearer '+ token
    When method GET
    * print 'response:', response
    Then status 400
    # Getting Mule Response
    * def MuleResponse_Code = response['error']['code']
    * print MuleResponse_Code
    * def MuleResponse_Message = response['error']['message']
    * print MuleResponse_Message
    # Reading L7 saved Response
    * print L7_InvalidResponse['Get_SSO_Token']['ccNumberString']
    * def L7Response_Code = L7_InvalidResponse['Get_SSO_Token']['ccNumberString']['error']['code']
    * print L7Response_Code
    * def L7Response_Message = L7_InvalidResponse['Get_SSO_Token']['ccNumberString']['error']['message']
    * print L7Response_Message
    # Matching response data
    * match L7Response_Code == MuleResponse_Code
    * match L7Response_Message == MuleResponse_Message

    # 7d Valid PartyID, and email with Invalid EmptyccNumber
  Scenario: 7d Check for response and compare same with layer 7 for invalid parameter - [EmptyccNumber]
    Given url Baseurl + subpath  
    And param partyId = PartyID
    And param ccNumber = ""
    And param email = email
    And header Authorization = 'Bearer '+ token
    When method GET
    * print 'response:', response
    Then status 400
    # Getting Mule Response
    * def MuleResponse_Code = response['error']['code']
    * print MuleResponse_Code
    * def MuleResponse_Message = response['error']['message']
    * print MuleResponse_Message
    # Reading L7 saved Response
    * print L7_InvalidResponse['Get_SSO_Token']['ccNumberString']
    * def L7Response_Code = L7_InvalidResponse['Get_SSO_Token']['EmptyccNumber']['error']['code']
    * print L7Response_Code
    * def L7Response_Message = L7_InvalidResponse['Get_SSO_Token']['EmptyccNumber']['error']['message']
    * print L7Response_Message
    # Matching response data
    * match L7Response_Code == MuleResponse_Code
    * match L7Response_Message == MuleResponse_Message

    # 7e Valid PartyID, and ccNumber with Invalid InvalidEmail
  Scenario: 7e Check for response and compare same with layer 7 for invalid parameter - [InvalidEmail]
    Given url Baseurl + subpath  
    And param partyId = PartyID
    And param ccNumber = ccNumberValid
    And param email = InvalidEmail
    And header Authorization = 'Bearer '+ token
    When method GET
    * print 'response:', response
    Then status 400
    # Getting Mule Response
    * def MuleResponse_Code = response['error']['code']
    * print MuleResponse_Code
    * def MuleResponse_Message = response['error']['message']
    * print MuleResponse_Message
    # Reading L7 saved Response
    * print L7_InvalidResponse['Get_SSO_Token']['ccNumberString']
    * def L7Response_Code = L7_InvalidResponse['Get_SSO_Token']['InvalidEmail']['error']['code']
    * print L7Response_Code
    * def L7Response_Message = L7_InvalidResponse['Get_SSO_Token']['InvalidEmail']['error']['message']
    * print L7Response_Message
    # Matching response data
    * match L7Response_Code == MuleResponse_Code
    * match L7Response_Message == MuleResponse_Message

 		# 8 Invalid Authentication Token
  Scenario: 8 Check for Mule api response with Invalid Authentication Token
    Given url Baseurl + subpath  
    And param partyId = PartyID
    And param ccNumber = ccNumberValid
    And param email = email
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ tokenInvalid
    When method GET
    * print response
    Then status 401