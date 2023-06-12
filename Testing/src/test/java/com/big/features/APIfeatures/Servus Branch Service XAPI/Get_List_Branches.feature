
Feature: Servus Branch | Get List Branches
Background:
    * def Baseurl = 'https://servus-branch-xapi.ca-c1.cloudhub.io/api/v1'
    * def subpath = '/branch?branchIds='
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
    * def LongBranchID = jsonPayload.LongBranchID
    * def NoBranchID = jsonPayload.NoBranchID
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
   
   # 4 response headers - Content-Type
  Scenario: 4 Check for response headers and its values and compare same with layer 7 - [Content-Type]
    Given url Baseurl + subpath + ValidBranchID
    And header Authorization = 'Bearer '+ token
    When method GET
    * print response
    Then status 200
    * print responseHeaders
    # Getting Mule Response
    * def ContentType_mule = responseHeaders["Content-Type"][0]
    # Reading L7 saved Response
    * def ContentType_L7 = Expected_headers['Get_List_Branches']['Response Headers']['content-type']
    # Matching response data
    And karate.match(ContentType_L7 == ContentType_mule, 'ignoreCase')   
   
    # 5 ResponseTime
  Scenario: 5 Check for responseTime and compare with expected response time - [ResponseTime]
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


    # 6 Valid BranchID
  Scenario: 6 Check for response and compare same with layer 7 for valid parameter -[BranchID]
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
    * def MuleResponse_Region = response['Response'][0]['Region']
    * print MuleResponse_Region
    * def MuleResponse_BranchNumber = response['Response'][0]['BranchNumber']
    * print MuleResponse_BranchNumber
    # Reading L7 saved Response
    * def L7_response_Message = L7_ValidResponse['List_Branches']['Messages']
    * print L7_response_Message
    * def L7_response_IsSuccess = L7_ValidResponse['List_Branches']['IsSuccess']
    * print L7_response_IsSuccess
    * def L7_response_Region = L7_ValidResponse['List_Branches']['Response'][0]['Region']
    * print L7_response_Region
    * def L7_response_BranchNumber = L7_ValidResponse['List_Branches']['Response'][0]['BranchNumber']
    * print L7_response_BranchNumber
    # Matching response data
    * match L7_response_Message == MuleResponse_Message   
    * match L7_response_IsSuccess == MuleResponse_IsSuccess 
    * match L7_response_Region == MuleResponse_Region 
    * match L7_response_BranchNumber == MuleResponse_BranchNumber    
   
   
    # 7a invalid BranchID
  Scenario: 7a Check for response and compare same with layer 7 for invalid parameter - [InvalidBranchID]
    Given url Baseurl + subpath + InvalidBranchID
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
    * def L7Response_ApiVersionNumber = L7_InvalidResponse['List_Branches']['InvalidBranchID']['ApiVersionNumber']
    * def L7Response_IsSuccess = L7_InvalidResponse['List_Branches']['InvalidBranchID']['IsSuccess']
    * print L7Response_ApiVersionNumber
    * print L7Response_IsSuccess
    # Matching response data
    * match L7Response_ApiVersionNumber == MuleResponse_ApiVersionNumber
    * match L7Response_IsSuccess == MuleResponse_IsSuccess

    # 7b NoBranchID
  Scenario: 7b Check for response and compare same with layer 7 for invalid parameter - [NoBranchID]
    Given url Baseurl + subpath + NoBranchID
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
    * def L7Response_ApiVersionNumber = L7_InvalidResponse['List_Branches']['NoBranchID']['ApiVersionNumber']
    * def L7Response_IsSuccess = L7_InvalidResponse['List_Branches']['NoBranchID']['IsSuccess']
    * print L7Response_ApiVersionNumber
    * print L7Response_IsSuccess
    # Matching response data
    * match L7Response_ApiVersionNumber == MuleResponse_ApiVersionNumber
    * match L7Response_IsSuccess == MuleResponse_IsSuccess
   
 		# 8 Invalid Authentication Token
  Scenario: 8 Check for Mule api response with Invalid Authentication Token
    Given url Baseurl + subpath + ValidBranchID
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ tokenInvalid
    When method GET
    * print response
    Then status 401