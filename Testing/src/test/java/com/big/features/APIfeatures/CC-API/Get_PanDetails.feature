Feature: CC XAPI | Get Accounts
Background:
    * def Baseurl = 'https://credit-card-xapi.ca-c1.cloudhub.io/api/v1'
    * def subpath = '/account/'
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
    * def PAN = jsonPayload.PAN
    * def PANInvalid = jsonPayload.PANInvalid
    * def StringPAN = jsonPayload.StringPAN
    * def PANInvalidLength = jsonPayload.PANInvalidLength
    * def resolutionValid = jsonPayload.resolutionValid
    * def resolutionInvalid = jsonPayload.resolutionInvalid
    # Printing saved data
    * print token
    * print jsonPayload
    * print ContentType
    * print Connection
    * print tokenInvalid
    * print ExpectedResponseTime
    * print Accept
    * print PAN 
    * print PANInvalid
    * print StringPAN
    * print PANInvalidLength
    * print resolutionValid
    * print resolutionInvalid
    # Reading Layer 7 Saved Data
    * def L7_ValidResponse = read('Response/valid_response.json')
    * def L7_InvalidResponse = read('Response/Invalid_response.json')
    * def Expected_headers = read('Response/Layer7_header_response.json')
   
   # 1 Mule API response with valid input
  Scenario: 1 Check for Mule API response with valid input
    Given url Baseurl + subpath + PAN + "/detail?resolution=" + resolutionValid
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   
   # 2 Mule API response with valid request header - [Connection,Accept]
  Scenario: 2 Check for Mule API response with valid request header - [Content-Type]
    Given url Baseurl + subpath + PAN + "/detail?resolution=" + resolutionValid
    And header Connection = Connection
    And header Accept = Accept
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   
   # 3 Mule API response with Invalid request header - [Content-Type]
  Scenario: 3 Check for Mule API response with Invalid request header - [Content-Type]
    Given url Baseurl + subpath + PAN + "/detail?resolution=" + resolutionValid
    And header Content-Type = InvalidContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   
   
    # 4 response headers - Content-Length
  Scenario: 4 Check for response headers and its values and compare same with layer 7 - [Content-Length]
    Given url Baseurl + subpath + PAN + "/detail?resolution=" + resolutionValid
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
    Given url Baseurl + subpath + PAN + "/detail?resolution=" + resolutionValid
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
    Given url Baseurl + subpath + PAN + "/detail?resolution=" + resolutionValid
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


    # 7a Valid resolution Case (=0,1,None,none) and valid PAN
  Scenario: 7a Check for response and compare same with layer 7 for valid parameter -[Valid resolution (=0,1,None,none) and valid PAN]
    Given url Baseurl + subpath + PAN + "/detail?resolution=" + resolutionValid_Case1
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    * print 'response:', response
    Then status 200
    # Getting Mule Response
    And def Response_mule = response
    * karate.remove('response', 'Timestamp')
    # Reading L7 saved Response
    * def L7_response_data = L7_ValidResponse['Get_PAN_Details1']
    * print L7_response_data
    # Matching response data
    * match L7_response_data == Response_mule   
   
    # 7b Valid resolution Case (=3) and valid PAN
  Scenario: 7b Check for response and compare same with layer 7 for Valid parameter - [Valid resolution (=3) and valid PAN]
    Given url Baseurl + subpath + PAN + "/detail?resolution=" + resolutionValid_Case2
    And header Authorization = 'Bearer '+ token
    When method GET
    * print 'response:', response
    Then status 200
    # Getting Mule Response
    And def Response_mule = response
    * karate.remove('response', 'Timestamp')
    # Reading L7 saved Response
    * def L7_response_data = L7_ValidResponse['Get_PAN_Details2']
    * print L7_response_data
    # Matching response data
    * match L7_response_data == Response_mule
    
    # 7c Valid resolution Case (=2) and valid PAN
  Scenario: 7c Check for response and compare same with layer 7 for Valid parameter - [Valid resolution (=2) and valid PAN]
    Given url Baseurl + subpath + PAN + "/detail?resolution=" + resolutionValid_Case3
    And header Authorization = 'Bearer '+ token
    When method GET
    * print 'response:', response
    Then status 200
    # Getting Mule Response
    And def Response_mule = response
    * karate.remove('response', 'Timestamp')
    # Reading L7 saved Response
    * def L7_response_data = L7_ValidResponse['Get_PAN_Details3']
    * print L7_response_data
    # Matching response data
    * match L7_response_data == Response_mule
    
  
    # 8a invalid resolution (4,5,a,....)
  Scenario: 8a Check for response and compare same with layer 7 for invalid parameter - [Invalid resolution and Valid PAN]
    Given url Baseurl + subpath + PAN + "/detail?resolution=" + resolutionInvalid
    #And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method GET
    * print 'response:', response
    Then status 400
    # Getting Mule Response
    * def MuleResponse_title = response['title']
    * print MuleResponse_title
    # Reading L7 saved Response
    * print L7_InvalidResponse
    * def L7Response_title = L7_InvalidResponse['GetAccountPanDetails']['InvalidResolution']['title']
    * print L7Response_title
    # Matching response data
    * match L7Response_title == MuleResponse_title


    # 8b Valid resolution and invalid PAN
  Scenario: 8b Check for response and compare same with layer 7 for invalid parameter - [Valid resolution and Inalid PAN]
    Given url Baseurl + subpath + PANInvalid + "/detail?resolution=" + resolutionValid_Case1
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
    * def L7Response_ApiVersionNumber = L7_InvalidResponse['GetAccountPanDetails']['InvalidPartyid']['ApiVersionNumber']
    * def L7Response_IsSuccess = L7_InvalidResponse['GetAccountPanDetails']['InvalidPartyid']['IsSuccess']
    * def L7Response_MessageCode = L7_InvalidResponse['GetAccountPanDetails']['InvalidPanNumber']['Messages'][0]['MessageCode']
    * def L7Response_MessageText = L7_InvalidResponse['GetAccountPanDetails']['InvalidPanNumber']['Messages'][0]['MessageText']
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
    Given url Baseurl + subpath + PAN + "/detail?resolution=" + resolutionValid
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ tokenInvalid
    When method GET
    * print response
    Then status 401