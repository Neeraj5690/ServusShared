
Feature: BAT | Create API

  Background: 
    * def Baseurl = 'https://bat-xapi.ca-c1.cloudhub.io/api/v1'
    * def subpath = '/create'
    # Getting Token Data
    * def resp = call read('GetToken.feature')
    * def token = resp.token
    # Reading Saved Data
    * def jsonPayload = read('SavedData.json')
    * def ContentType = jsonPayload.ContentType
    * def InvalidContentType = jsonPayload.InvalidContentType
    * def tokenInvalid = jsonPayload.InvalidToken
    * def ExpectedResponseTime = jsonPayload.ExpectedResponseTime_Create
    * def MemberNumber = jsonPayload.memberNumber
    * def MemberNumberInvalid = jsonPayload.memberNumberInvalid
    * def LargeMemberNumber = jsonPayload.LargeMemberNumber
    * def PartyId = jsonPayload.partyId
    * def CardNumber = jsonPayload.cardNumber
    * def CardHolderName = jsonPayload.cardHolderName
    * def CreditLimit = jsonPayload.creditLimit
    * def PromotionCode = jsonPayload.promotionCode
    * def Fees = jsonPayload.fees
    * def ContactMethod = jsonPayload.contactMethod
    * def ContactInfo = jsonPayload.contactInfo
    * def UserId = jsonPayload.userId
    * def Amount = jsonPayload['payeeRequests'][0].amount
    * def ExternalId = jsonPayload['payeeRequests'][0].externalId
    * def PayeeType = jsonPayload['payeeRequests'][0].payeeType
    * def Display = jsonPayload['payeeRequests'][0].display
    
    # Printing saved data
    * print token
    * print ContentType
    * print InvalidContentType
    * print tokenInvalid
    * print ExpectedResponseTime
    * print MemberNumber
    * print MemberNumberInvalid
    * print LargeMemberNumber
    * print PartyId
    * print CardNumber
    * print CardHolderName
    * print CreditLimit
    * print PromotionCode
    * print Fees
    * print ContactMethod
    * print ContactInfo
    * print UserId
    * print Amount
    * print ExternalId
    * print PayeeType
    * print Display
    
    
    # Reading Layer 7 Saved Data
    * def L7_response = read('Response/valid_response.json')
    * def L7_InvalidResponse = read('Response/Invalid_response.json')
    * def Expected_headers = read('Response/Layer7_header_response.json')

  # 1 Mule API response with valid input
  Scenario: 1 Check for Mule API response with valid input
    Given url Baseurl + subpath
    And request {"memberNumber": '#(MemberNumber)',"partyId": '#(PartyId)',"cardNumber": '#(CardNumber)', "cardHolderName": 'CardHolderName',"creditLimit": '#(CreditLimit)',"promotionCode": '#(PromotionCode)',"fees": '#(Fees)',"contactMethod": "EMAIL","contactInfo": '#(ContactInfo)',"userId": '#(UserId)', "payeeRequests": [{"amount": '#(Amount)',"externalId": '#(ExternalId)',"payeeType": '#(PayeeType)',"display": '#(Display)'}]}
    And header Authorization = 'Bearer '+ token
    When method POST
    * print response
    Then status 200

  # 2 Mule API response with valid request header - [Content-Type]
  Scenario: 2 Check for Mule API response with valid request header - [Content-Type]
    Given url Baseurl + subpath
    And request {"memberNumber": '#(MemberNumber)',"partyId": '#(PartyId)',"cardNumber": '#(CardNumber)', "cardHolderName": 'CardHolderName',"creditLimit": '#(CreditLimit)',"promotionCode": '#(PromotionCode)',"fees": '#(Fees)',"contactMethod": "EMAIL","contactInfo": '#(ContactInfo)',"userId": '#(UserId)', "payeeRequests": [{"amount": '#(Amount)',"externalId": '#(ExternalId)',"payeeType": '#(PayeeType)',"display": '#(Display)'}]}
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method POST
    * print response
    Then status 200

  # 3 Mule API response with Invalid request header - [Content-Type]
  Scenario: 3 Check for Mule API response with Invalid request header - [Content-Type]
    Given url Baseurl + subpath
    And request {"memberNumber": '#(MemberNumber)',"partyId": '#(PartyId)',"cardNumber": '#(CardNumber)', "cardHolderName": 'CardHolderName',"creditLimit": '#(CreditLimit)',"promotionCode": '#(PromotionCode)',"fees": '#(Fees)',"contactMethod": "EMAIL","contactInfo": '#(ContactInfo)',"userId": '#(UserId)', "payeeRequests": [{"amount": '#(Amount)',"externalId": '#(ExternalId)',"payeeType": '#(PayeeType)',"display": '#(Display)'}]}
    And header Content-Type = InvalidContentType
    And header Authorization = 'Bearer '+ token
    When method POST
    * print response
    Then status 415

  # 4 response headers - Content-Type
  Scenario: 4 Check for response headers and its values and compare same with layer 7 - [Content-Type]
    Given url Baseurl + subpath
    And request {"memberNumber": '#(MemberNumber)',"partyId": '#(PartyId)',"cardNumber": '#(CardNumber)', "cardHolderName": 'CardHolderName',"creditLimit": '#(CreditLimit)',"promotionCode": '#(PromotionCode)',"fees": '#(Fees)',"contactMethod": "EMAIL","contactInfo": '#(ContactInfo)',"userId": '#(UserId)', "payeeRequests": [{"amount": '#(Amount)',"externalId": '#(ExternalId)',"payeeType": '#(PayeeType)',"display": '#(Display)'}]}
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

  # 5 ResponseTime
  Scenario: 5 Check for responseTime and compare with expected response time - [ResponseTime]
    Given url Baseurl + subpath
    And request {"memberNumber": '#(MemberNumber)',"partyId": '#(PartyId)',"cardNumber": '#(CardNumber)', "cardHolderName": 'CardHolderName',"creditLimit": '#(CreditLimit)',"promotionCode": '#(PromotionCode)',"fees": '#(Fees)',"contactMethod": "EMAIL","contactInfo": '#(ContactInfo)',"userId": '#(UserId)', "payeeRequests": [{"amount": '#(Amount)',"externalId": '#(ExternalId)',"payeeType": '#(PayeeType)',"display": '#(Display)'}]}
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
    * def Layer7_responseTime = 5610
    # Matching response data
    * assert responseTime <= Expected_responseTime

  # 6 Valid member number 
  Scenario: 6 Check for response and compare same with layer 7 for valid key body parameter -[member number]
    Given url Baseurl + subpath
    And request {"memberNumber": '#(MemberNumber)',"partyId": '#(PartyId)',"cardNumber": '#(CardNumber)', "cardHolderName": 'CardHolderName',"creditLimit": '#(CreditLimit)',"promotionCode": '#(PromotionCode)',"fees": '#(Fees)',"contactMethod": "EMAIL","contactInfo": '#(ContactInfo)',"userId": '#(UserId)', "payeeRequests": [{"amount": '#(Amount)',"externalId": '#(ExternalId)',"payeeType": '#(PayeeType)',"display": '#(Display)'}]}
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method POST
    * print 'response:', response
    Then status 200
    # Getting Mule Response
    And def Response_mule = response
    * karate.remove('response', 'timestamp')
    * karate.remove('response', 'id')
    #* karate.remove('response', 'response', 'id')
    * karate.remove('response', 'requestedDate')
    # Reading L7 saved Response
    * def L7_response_data = L7_response['Create']
    And print L7_response_data
    # Matching response data
    * match L7_response_data == Response_mule

  # 7 invalid member number
  Scenario: 7 Check for response and compare same with layer 7 for invalid key body parameter - [member number]
    Given url Baseurl + subpath
    And request {"memberNumber": '#(MemberNumberInvalid)',"partyId": '#(PartyId)',"cardNumber": '#(CardNumber)', "cardHolderName": 'CardHolderName',"creditLimit": '#(CreditLimit)',"promotionCode": '#(PromotionCode)',"fees": '#(Fees)',"contactMethod": "EMAIL","contactInfo": '#(ContactInfo)',"userId": '#(UserId)', "payeeRequests": [{"amount": '#(Amount)',"externalId": '#(ExternalId)',"payeeType": '#(PayeeType)',"display": '#(Display)'}]}
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method POST
    * print 'response:', response
    Then status 400
    #Getting Mule Response
    * def MuleResponse_messageText = response['errors']['memberNumber'][0]
    * def MuleResponse_messageTitle = response['title']
    * print MuleResponse_messageText
    * print MuleResponse_messageTitle
    # Reading L7 saved Response
    * print L7_InvalidResponse
    * def L7Response_messageText = L7_InvalidResponse['Create']['errors']['memberNumber'][0]
    * def L7Response_messageTitle = L7_InvalidResponse['Create']['title']
    # Matching response data
    * match L7Response_messageText == MuleResponse_messageText
    * match L7Response_messageTitle == MuleResponse_messageTitle
    

  # 8 Invalid Authentication Token
  Scenario: 8 Check for Mule api response with Invalid Authentication Token
    Given url Baseurl + subpath
    And request {"memberNumber": '#(MemberNumber)',"partyId": '#(PartyId)',"cardNumber": '#(CardNumber)', "cardHolderName": 'CardHolderName',"creditLimit": '#(CreditLimit)',"promotionCode": '#(PromotionCode)',"fees": '#(Fees)',"contactMethod": "EMAIL","contactInfo": '#(ContactInfo)',"userId": '#(UserId)', "payeeRequests": [{"amount": '#(Amount)',"externalId": '#(ExternalId)',"payeeType": '#(PayeeType)',"display": '#(Display)'}]}
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ tokenInvalid
    When method POST
    * print response
    Then status 401

  # 9 Missing Content in body
  Scenario: 9 Check for Mule api response with missing Content in body
    Given url Baseurl + subpath
    #And request {"memberNumber": '#(MemberNumber)',"partyId": '#(PartyId)',"cardNumber": '#(CardNumber)', "cardHolderName": 'CardHolderName',"creditLimit": '#(CreditLimit)',"promotionCode": '#(PromotionCode)',"fees": '#(Fees)',"contactMethod": "EMAIL","contactInfo": '#(ContactInfo)',"userId": '#(UserId)', "payeeRequests": [{"amount": '#(Amount)',"externalId": '#(ExternalId)',"payeeType": '#(PayeeType)',"display": '#(Display)'}]}
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method POST
    * print response
    Then status 400
    * match response['errors'][''][0] == 'A non-empty request body is required.'

  # 10 Increased input limit
  Scenario: 11 Check for Mule api response with Increased input limit in filed - [memberNumber]
    Given url Baseurl + subpath
    And print MemberNumber
    And request {"memberNumber": '#(LargeMemberNumber)',"partyId": '#(PartyId)',"cardNumber": '#(CardNumber)', "cardHolderName": 'CardHolderName',"creditLimit": '#(CreditLimit)',"promotionCode": '#(PromotionCode)',"fees": '#(Fees)',"contactMethod": "EMAIL","contactInfo": '#(ContactInfo)',"userId": '#(UserId)', "payeeRequests": [{"amount": '#(Amount)',"externalId": '#(ExternalId)',"payeeType": '#(PayeeType)',"display": '#(Display)'}]}
    And header Content-Type = ContentType
    And header Authorization = 'Bearer '+ token
    When method POST
    * print response
    Then status 400
