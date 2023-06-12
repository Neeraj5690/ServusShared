
Feature: Servus Branch | Get List ATM
Background:
    * def Baseurl = 'https://servus-branch-xapi.ca-c1.cloudhub.io/api/v1'
    * def subpath = '/atm?search.cityName='
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
    * def BranchCity = jsonPayload.BranchCity
    * def InvalidBranchCity = jsonPayload.InvalidBranchCity
    # Printing saved data
    * print token
    * print jsonPayload
    * print ContentType
    * print Connection
    * print tokenInvalid
    * print ExpectedResponseTime
    * print Accept
    * print BranchCity 
    * print InvalidBranchCity
    # Reading Layer 7 Saved Data
    * def L7_ValidResponse = read('Response/valid_response.json')
    * def L7_InvalidResponse = read('Response/Invalid_response.json')
    * def Expected_headers = read('Response/Layer7_header_response.json')
   
   # 1 Mule API response with valid input
  Scenario: 1 Check for Mule API response with valid input
    Given url Baseurl + subpath + BranchCity
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   
   # 2 Mule API response with valid request header - [Connection,Accept]
  Scenario: 2 Check for Mule API response with valid request header - [Content-Type]
    Given url Baseurl + subpath + BranchCity
    And header Connection = Connection
    And header Accept = Accept
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   
   # 3 Mule API response with Invalid request header - [Content-Type]
  Scenario: 3 Check for Mule API response with Invalid request header - [Content-Type]
    Given url Baseurl + subpath + BranchCity
    And header Content-Type = InvalidContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   
   # 4 response headers - Content-Type
  Scenario: 4 Check for response headers and its values and compare same with layer 7 - [Content-Type]
    Given url Baseurl + subpath + BranchCity
    And header Authorization = 'Bearer '+ token
    When method GET
    * print response
    Then status 200
    * print responseHeaders
    # Getting Mule Response
    * def ContentType_mule = responseHeaders["Content-Type"][0]
    # Reading L7 saved Response
    * def ContentType_L7 = Expected_headers['Get_List_ATM']['Response Headers']['content-type']
    # Matching response data
    And karate.match(ContentType_L7 == ContentType_mule, 'ignoreCase')   
   
    # 5 ResponseTime
  Scenario: 5 Check for responseTime and compare with expected response time - [ResponseTime]
    Given url Baseurl + subpath + BranchCity
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


    # 6 Valid BranchCity
  Scenario: 6 Check for response and compare same with layer 7 for valid parameter -[BranchCity]
    Given url Baseurl + subpath + BranchCity
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
    * def MuleResponse_MakeBrand = response['Response'][0]['ATMMake']['MakeBrand']
    * print MuleResponse_MakeBrand
    * def MuleResponse_Branch = response['Response'][0]['Branch']
    * print MuleResponse_Branch
    # Reading L7 saved Response
    * def L7_response_Message = L7_ValidResponse['List_ATM']['Messages']
    * print L7_response_Message
    * def L7_response_IsSuccess = L7_ValidResponse['List_ATM']['IsSuccess']
    * print L7_response_IsSuccess
    * def L7_response_MakeBrand = L7_ValidResponse['List_ATM']['Response'][0]['ATMMake']['MakeBrand']
    * print L7_response_MakeBrand
    * def L7_response_Branch = L7_ValidResponse['List_ATM']['Response'][0]['Branch']
    * print L7_response_Branch
    # Matching response data
    * match L7_response_Message == MuleResponse_Message   
    * match L7_response_IsSuccess == MuleResponse_IsSuccess 
    * match L7_response_MakeBrand == MuleResponse_MakeBrand 
    * match L7_response_Branch == MuleResponse_Branch 
   
   
    # 7a Invalid BranchCity
  Scenario: 7a Check for response and compare same with layer 7 for invalid parameter - [InvalidBranchCity]
    Given url Baseurl + subpath + InvalidBranchCity
    #And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    * print 'response:', response
    Then status 200
    # Getting Mule Response
    * def MuleResponse_Response = response['Response']
    * print MuleResponse_Response
    # Reading L7 saved Response
    * print L7_InvalidResponse
    * def L7Response_Response = L7_InvalidResponse['List_ATM']['Response']
    * print L7Response_Response
    # Matching response data
    * match L7Response_Response == MuleResponse_Response
   
    
 		# 8 Invalid Authentication Token
  Scenario: 9 Check for Mule api response with Invalid Authentication Token
    Given url Baseurl + subpath + BranchCity
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ tokenInvalid
    When method GET
    * print response
    Then status 401