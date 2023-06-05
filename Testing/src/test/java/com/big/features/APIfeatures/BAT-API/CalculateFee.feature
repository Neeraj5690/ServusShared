Feature: BAT | Calculate Fee API

  Background: 
    * def Baseurl = 'https://bat-xapi.ca-c1.cloudhub.io/api/v1'
    * def subpath = '/calculatefee'
    # Getting Token Data
    * def resp = call read('GetToken.feature')
    * def token = resp.token
    # Reading Saved Data
    * def jsonPayload = read('SavedData.json')
    * def ContentType = jsonPayload.ContentType
    * def InvalidContentType = jsonPayload.InvalidContentType
    * def tokenInvalid = jsonPayload.InvalidToken
    * def ExpectedResponseTime = jsonPayload.ExpectedResponseTime
    * def MemberNumber = jsonPayload.memberNumber
    * def MemberNumberInvalid = jsonPayload.memberNumberInvalid
    * def LargeMemberNumber = jsonPayload.LargeMemberNumber
    * def MinimumFee = jsonPayload.minimumFee
    * def FeePercent = jsonPayload.feePercent
    * def PaymentAmounts = jsonPayload.paymentAmounts
    * def InvalidPaymentAmounts = jsonPayload.InvalidPaymentAmounts
    # Printing saved data
    * print token
    * print ContentType
    * print InvalidContentType
    * print tokenInvalid
    * print ExpectedResponseTime
    * print MemberNumber
    * print MemberNumberInvalid
    * print LargeMemberNumber
    * print MinimumFee
    * print FeePercent
    * print PaymentAmounts
    * print InvalidPaymentAmounts
    # Reading Layer 7 Saved Data
    * def L7_response = read('Response/valid_response.json')
    * def L7_InvalidResponse = read('Response/Invalid_response.json')
    * def Expected_headers = read('Response/Layer7_header_response.json')

  # 1 Mule API response with valid input
  Scenario: 1 Check for Mule API response with valid input
    Given url Baseurl + subpath
    And request {"minimumFee": '#(MinimumFee)',"feePercent": '#(FeePercent)',"paymentAmounts": '#(PaymentAmounts)'}
    And header Authorization = 'Bearer '+ token
    When method POST
    * print response
    Then status 200

  # 2 Mule API response with valid request header - [Content-Type]
  Scenario: 2 Check for Mule API response with valid request header - [Content-Type]
    Given url Baseurl + subpath
    And request {"minimumFee": '#(MinimumFee)',"feePercent": '#(FeePercent)',"paymentAmounts": '#(PaymentAmounts)'}
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method POST
    * print response
    Then status 200

  # 3 Mule API response with Invalid request header - [Content-Type]
  Scenario: 3 Check for Mule API response with Invalid request header - [Content-Type]
    Given url Baseurl + subpath
    And request {"xyz": 'xyz'}
    And header Content-Type = InvalidContentType
    And header Authorization = 'Bearer '+ token
    When method POST
    * print response
    Then status 415

  # 4 response headers - Content-Length
  Scenario: 4 Check for response headers and its values and compare same with layer 7 - [Content-Length]
    Given url Baseurl + subpath
    And request {"minimumFee": '#(MinimumFee)',"feePercent": '#(FeePercent)',"paymentAmounts": '#(PaymentAmounts)'}
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method POST
    * print response
    * print responseHeaders
    Then status 200
    # Getting Mule Response
    * def ContentLength_mule = responseHeaders["Content-Length"][0]
    # Reading L7 saved Response
    * def ContentLength_L7 = Expected_headers['calculate']['Response Headers']['content-length']
    # Matching response data
    And match ContentLength_L7 == ContentLength_mule

  # 5 response headers - Content-Type
  Scenario: 5 Check for response headers and its values and compare same with layer 7 - [Content-Type]
    Given url Baseurl + subpath
    And request {"minimumFee": '#(MinimumFee)',"feePercent": '#(FeePercent)',"paymentAmounts": '#(PaymentAmounts)'}
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method POST
    * print response
    Then status 200
    * print responseHeaders
    # Getting Mule Response
    * def ContentType_mule = responseHeaders["Content-Type"][0]
    # Reading L7 saved Response
    * def ContentType_L7 = Expected_headers['calculate']['Response Headers']['content-type']
    # Matching response data
    And karate.match(ContentType_L7 == ContentType_mule, 'ignoreCase')

  # 6 ResponseTime
  Scenario: 6 Check for responseTime and compare with expected response time - [ResponseTime]
    Given url Baseurl + subpath
    And request {"minimumFee": '#(MinimumFee)',"feePercent": '#(FeePercent)',"paymentAmounts": '#(PaymentAmounts)'}
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method POST
    * print response
    Then status 200
    # Getting Mule Response
    * def responseTime = karate.get('responseTime')
    And print responseTime
    # Reading expected saved Response
    * def Expected_responseTime = ExpectedResponseTime
    And print Expected_responseTime
    * def Layer7_responseTime = 686
    # Matching response data
    * assert responseTime <= Expected_responseTime

  # 7 Valid Payment Amount 
  Scenario: 7 Check for response and compare same with layer 7 for valid key body parameter -[PaymentAmounts]
    Given url Baseurl + subpath
    And request {"minimumFee": '#(MinimumFee)',"feePercent": '#(FeePercent)',"paymentAmounts": '#(PaymentAmounts)'}
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method POST
    * print 'response:', response
    Then status 200
    # Getting Mule Response
    And def Response_mule = response
    * karate.remove('response', 'timestamp')
    * karate.remove('response', 'referenceNumber')
    # Reading L7 saved Response
    * def L7_response_data = L7_response['Calculate Fee']
    And print L7_response_data
    # Matching response data
    * match L7_response_data == Response_mule

  # 8 invalid PaymentAmounts
  Scenario: 8 Check for response and compare same with layer 7 for invalid key body parameter - [PaymentAmounts]
    Given url Baseurl + subpath
    And request {"minimumFee": '#(MinimumFee)',"feePercent": '#(FeePercent)',"paymentAmounts": 'abc'}
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method POST
    * print 'response:', response
    Then status 400
    #Getting Mule Response
    * def MuleResponse_messageText = response['errors']['paymentAmounts'][0]
    * def MuleResponse_messageTitle = response['title']
    * print MuleResponse_messageText
    * print MuleResponse_messageTitle
    # Reading L7 saved Response
    * print L7_InvalidResponse
    * def L7Response_messageText = L7_InvalidResponse['Calculate Fee']['errors']['paymentAmounts'][0]
    * def L7Response_messageTitle = L7_InvalidResponse['Calculate Fee']['title']
    # Matching response data
    * match L7Response_messageText == MuleResponse_messageText
    * match L7Response_messageTitle == MuleResponse_messageTitle
    

  # 9 Invalid Authentication Token
  Scenario: 9 Check for Mule api response with Invalid Authentication Token
    Given url Baseurl + subpath
    And request {"minimumFee": '#(MinimumFee)',"feePercent": '#(FeePercent)',"paymentAmounts": '#(PaymentAmounts)'}
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ tokenInvalid
    When method POST
    * print response
    Then status 401

  # 10 Missing Content in body
  Scenario: 10 Check for Mule api response with missing Content in body
    Given url Baseurl + subpath
    #And request {"minimumFee": '#(MinimumFee)',"feePercent": '#(FeePercent)',"paymentAmounts": '#(PaymentAmounts)'}
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method POST
    * print response
    Then status 400
    * match response['errors'][''][0] == 'A non-empty request body is required.'

  # 11 Increased input limit
  Scenario: 11 Check for Mule api response with Increased input limit in filed - [PaymentAmounts]
    Given url Baseurl + subpath
    And print MemberNumber
    And request {"minimumFee": '#(MinimumFee)',"feePercent": '#(FeePercent)',"paymentAmounts": '#(InvalidPaymentAmounts)'}
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method POST
    * print response
    Then status 400
