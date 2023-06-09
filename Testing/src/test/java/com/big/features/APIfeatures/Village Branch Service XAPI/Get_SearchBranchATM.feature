
Feature: Village Branch | Search Branch ATM
Background:
    * def Baseurl = 'https://village-branch-directory-xapi.ca-c1.cloudhub.io/api/v1'
    * def subpath = '/search/branchatm?search.searchKeyword='
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
    * def BranchName = jsonPayload.BranchName
    * def InvalidBranchName = jsonPayload.InvalidBranchName
    # Printing saved data
    * print token
    * print jsonPayload
    * print ContentType
    * print Connection
    * print tokenInvalid
    * print ExpectedResponseTime
    * print Accept
    * print BranchName 
    * print InvalidBranchName
    # Reading Layer 7 Saved Data
    * def L7_ValidResponse = read('Response/valid_response.json')
    * def L7_InvalidResponse = read('Response/Invalid_response.json')
    * def Expected_headers = read('Response/Layer7_header_response.json')
   
   # 1 Mule API response with valid input
  Scenario: 1 Check for Mule API response with valid input
    Given url Baseurl + subpath + BranchName
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   
   # 2 Mule API response with valid request header - [Connection,Accept]
  Scenario: 2 Check for Mule API response with valid request header - [Content-Type]
    Given url Baseurl + subpath + BranchName
    And header Connection = Connection
    And header Accept = Accept
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   
   # 3 Mule API response with Invalid request header - [Content-Type]
  Scenario: 3 Check for Mule API response with Invalid request header - [Content-Type]
    Given url Baseurl + subpath + BranchName
    And header Content-Type = InvalidContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   
  @ignore 
    # 4 response headers - Content-Length
  Scenario: 4 Check for response headers and its values and compare same with layer 7 - [Content-Length]
    Given url Baseurl + subpath + BranchName
    And header Authorization = 'Bearer '+ token
    When method GET
    * print response
    * print responseHeaders
    Then status 200
    # Getting Mule Response
    * def ContentLength_mule = responseHeaders["Content-Length"][0]
    # Reading L7 saved Response
    * def ContentLength_L7 = Expected_headers['Get_SearchBranchATM']['Response Headers']['content-length']
    # Matching response data
    And match ContentLength_L7 == ContentLength_mule
   

    # 5 response headers - Content-Type
  Scenario: 5 Check for response headers and its values and compare same with layer 7 - [Content-Type]
    Given url Baseurl + subpath + BranchName
    And header Authorization = 'Bearer '+ token
    When method GET
    * print response
    Then status 200
    * print responseHeaders
    # Getting Mule Response
    * def ContentType_mule = responseHeaders["Content-Type"][0]
    # Reading L7 saved Response
    * def ContentType_L7 = Expected_headers['Get_SearchBranchATM']['Response Headers']['content-type']
    # Matching response data
    And karate.match(ContentType_L7 == ContentType_mule, 'ignoreCase')   
   
    # 6 ResponseTime
  Scenario: 6 Check for responseTime and compare with expected response time - [ResponseTime]
    Given url Baseurl + subpath + BranchName
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


    # 7 Valid BranchName
  Scenario: 7 Check for response and compare same with layer 7 for valid parameter -[BranchName]
    Given url Baseurl + subpath + BranchName
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
    * def MuleResponse_ID = response['Response'][0]['Id']
    * print MuleResponse_ID
    * def MuleResponse_Number = response['Response'][0]['Number']
    * print MuleResponse_Number
    * def MuleResponse_Name = response['Response'][0]['Name']
    * print MuleResponse_Name
    # Reading L7 saved Response
    * def L7_response_Message = L7_ValidResponse['Search_Branch_ATM']['Messages']
    * print L7_response_Message
    * def L7_response_IsSuccess = L7_ValidResponse['Search_Branch_ATM']['IsSuccess']
    * print L7_response_IsSuccess
    * def L7_response_ID = L7_ValidResponse['Search_Branch_ATM']['Response'][0]['Id']
    * print L7_response_ID
    * def L7_response_Number = L7_ValidResponse['Search_Branch_ATM']['Response'][0]['Number']
    * print L7_response_Number
    * def L7_response_Name = L7_ValidResponse['Search_Branch_ATM']['Response'][0]['Name']
    * print L7_response_Name
    # Matching response data
    * match L7_response_Message == MuleResponse_Message   
    * match L7_response_IsSuccess == MuleResponse_IsSuccess 
    * match L7_response_ID == MuleResponse_ID 
    * match L7_response_Number == MuleResponse_Number    
    * match L7_response_Name == MuleResponse_Name    
   
   
    # 8 InvalidBranchName
  Scenario: 8 Check for response and compare same with layer 7 for invalid parameter - [InvalidBranchName]
    Given url Baseurl + subpath + InvalidBranchName
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
    * def L7Response_ApiVersionNumber = L7_InvalidResponse['Search_Branch_ATM']['InvalidBranchName']['ApiVersionNumber']
    * def L7Response_IsSuccess = L7_InvalidResponse['Search_Branch_ATM']['InvalidBranchName']['IsSuccess']
    * print L7Response_ApiVersionNumber
    * print L7Response_IsSuccess
    # Matching response data
    * match L7Response_ApiVersionNumber == MuleResponse_ApiVersionNumber
    * match L7Response_IsSuccess == MuleResponse_IsSuccess
   
 		# 9 Invalid Authentication Token
  Scenario: 9 Check for Mule api response with Invalid Authentication Token
    Given url Baseurl + subpath + BranchName
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ tokenInvalid
    When method GET
    * print response
    Then status 401