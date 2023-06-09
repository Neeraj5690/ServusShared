@ignore
Feature: Village Branch | Get Branch by ID
Background:
    * def Baseurl = 'https://village-branch-directory-xapi.ca-c1.cloudhub.io/api/v1'
    * def subpath = '/branch/'
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
    * def ValidBranchID = jsonPayload.ValidBranchID
    * def InvalidBranchID = jsonPayload.InvalidBranchID
    * def NoBranchID = jsonPayload.NoBranchID
    * def LongBranchID = jsonPayload.LongBranchID
    # Printing saved data
    * print token
    * print jsonPayload
    * print ContentType
    * print Connection
    * print tokenInvalid
    * print ExpectedResponseTime
    * print Accept
    * print ValidBranchID 
    * print InvalidBranchID
    * print LongBranchID
    * print NoBranchID
    # Reading Layer 7 Saved Data
    * def L7_ValidResponse = read('Response/valid_response.json')
    * def L7_InvalidResponse = read('Response/Invalid_response.json')
    * def Expected_headers = read('Response/Layer7_header_response.json')
   
   # 1 Mule API response with valid input
  Scenario: 1 Check for Mule API response with valid input
    Given url Baseurl + subpath + ValidBranchID
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   
   # 2 Mule API response with valid request header - [Connection,Accept]
  Scenario: 2 Check for Mule API response with valid request header - [Content-Type]
    Given url Baseurl + subpath + ValidBranchID
    And header Connection = Connection
    And header Accept = Accept
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   
   # 3 Mule API response with Invalid request header - [Content-Type]
  Scenario: 3 Check for Mule API response with Invalid request header - [Content-Type]
    Given url Baseurl + subpath + ValidBranchID
    And header Content-Type = InvalidContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   
  @ignore 
    # 4 response headers - Content-Length
  Scenario: 4 Check for response headers and its values and compare same with layer 7 - [Content-Length]
    Given url Baseurl + subpath + ValidBranchID
    And header Authorization = 'Bearer '+ token
    When method GET
    * print response
    * print responseHeaders
    Then status 200
    # Getting Mule Response
    * def ContentLength_mule = responseHeaders["Content-Length"][0]
    # Reading L7 saved Response
    * def ContentLength_L7 = Expected_headers['Get_Branch_by_ID']['Response Headers']['content-length']
    # Matching response data
    And match ContentLength_L7 == ContentLength_mule
   

    # 5 response headers - Content-Type
  Scenario: 5 Check for response headers and its values and compare same with layer 7 - [Content-Type]
    Given url Baseurl + subpath + ValidBranchID
    And header Authorization = 'Bearer '+ token
    When method GET
    * print response
    Then status 200
    * print responseHeaders
    # Getting Mule Response
    * def ContentType_mule = responseHeaders["Content-Type"][0]
    # Reading L7 saved Response
    * def ContentType_L7 = Expected_headers['Get_Branch_by_ID']['Response Headers']['content-type']
    # Matching response data
    And karate.match(ContentType_L7 == ContentType_mule, 'ignoreCase')   
   
    # 6 ResponseTime
  Scenario: 6 Check for responseTime and compare with expected response time - [ResponseTime]
    Given url Baseurl + subpath + ValidBranchID
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


    # 7 Valid ValidBranchID
  Scenario: 7 Check for response and compare same with layer 7 for valid parameter -[ValidBranchID]
    Given url Baseurl + subpath + ValidBranchID
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    * print 'response:', response
    Then status 200
    # Getting Mule Response
    * def MuleResponse_Message = response['Messages']
    * print MuleResponse_Message
    * def MuleResponse_IsSuccess = response['IsSuccess']
    * print MuleResponse_IsSuccess
    * def MuleResponse_BranchId = response['Response']['BranchId']
    * print MuleResponse_BranchId
    * def MuleResponse_BranchNumber = response['Response']['BranchNumber']
    * print MuleResponse_BranchNumber
    # Reading L7 saved Response
    * def L7_response_Message = L7_ValidResponse['Branch_By_ID']['Messages']
    * print L7_response_Message
    * def L7_response_IsSuccess = L7_ValidResponse['Branch_By_ID']['IsSuccess']
    * print L7_response_IsSuccess
    * def L7_response_BranchId = L7_ValidResponse['Branch_By_ID']['Response']['BranchId']
    * print L7_response_BranchId
    * def L7_response_BranchNumber = L7_ValidResponse['Branch_By_ID']['Response']['BranchNumber']
    * print L7_response_BranchNumber
    # Matching response data
    * match L7_response_Message == MuleResponse_Message   
    * match L7_response_IsSuccess == MuleResponse_IsSuccess 
    * match L7_response_BranchId == MuleResponse_BranchId 
    * match L7_response_BranchNumber == MuleResponse_BranchNumber 
   
   
    # 8a Invalid BranchID
  Scenario: 8a Check for response and compare same with layer 7 for invalid parameter - [InvalidBranchID]
    Given url Baseurl + subpath + InvalidBranchID
    #And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    * print 'response:', response
    Then status 400
    # Getting Mule Response
    * def MuleResponse_Message = response['Message']
    * print MuleResponse_Message
    # Reading L7 saved Response
    * print L7_InvalidResponse
    * def L7Response_Message = L7_InvalidResponse['Branch_By_ID']['InvalidBranchID']['Message']
    * print L7Response_Message
    # Matching response data
    * match L7Response_Message == MuleResponse_Message
   
    # 8b No BranchID
  Scenario: 8b Check for response and compare same with layer 7 for invalid parameter - [NoBranchID]
    Given url Baseurl + subpath + NoBranchID
    #And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    * print 'response:', response
    Then status 200
    # Getting Mule Response
    * def MuleResponse_ApiVersionNumber = response['ApiVersionNumber']
    * def MuleResponse_IsSuccess = response['IsSuccess']
    * def MuleResponse_MessageCode = response['Messages'][0]['MessageCode']
    * def MuleResponse_MessageText = response['Messages'][0]['MessageText']
    * print MuleResponse_ApiVersionNumber
    * print MuleResponse_IsSuccess
    * print MuleResponse_MessageCode
    * print MuleResponse_MessageText
    # Reading L7 saved Response
    * print L7_InvalidResponse
    * def L7Response_ApiVersionNumber = L7_InvalidResponse['Branch_By_ID']['NoBranchID']['ApiVersionNumber']
    * def L7Response_IsSuccess = L7_InvalidResponse['Branch_By_ID']['NoBranchID']['IsSuccess']
    * def L7Response_MessageCode = L7_InvalidResponse['Branch_By_ID']['NoBranchID']['Messages'][0]['MessageCode']
    * def L7Response_MessageText = L7_InvalidResponse['Branch_By_ID']['NoBranchID']['Messages'][0]['MessageText']
    * print L7Response_ApiVersionNumber
    * print L7Response_IsSuccess
    * print L7Response_MessageCode
    * print L7Response_MessageText
    # Matching response data
    * match L7Response_ApiVersionNumber == MuleResponse_ApiVersionNumber
    * match L7Response_IsSuccess == MuleResponse_IsSuccess 
    * match MuleResponse_MessageCode == L7Response_MessageCode
    * match MuleResponse_MessageText == L7Response_MessageText 

 		# 9 Invalid Authentication Token
  Scenario: 9 Check for Mule api response with Invalid Authentication Token
    Given url Baseurl + subpath + ValidBranchID
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ tokenInvalid
    When method GET
    * print response
    Then status 401