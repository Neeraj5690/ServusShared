@ignore
Feature: Doc_Image_XAPI

  Background: 
    * def Baseurl = 'https://doc-image-xapi.ca-c1.cloudhub.io/api/v1/'
    * def jsonPayload = read('Chq_Img_request.json')
    * def jsonPayload2 = read('Stmt_List_request.json')
    * def jsonPayload3 = read('Stmt_request.json')

  Scenario: POST Cheque Image
    * def Expected_output = read('Response/POST_Cheque_Image_Response.json')
    Given url Baseurl + 'docimage-api/chequeimage'
    And request jsonPayload
    When method POST
    Then status 200
    * print 'response:', response
    And match response contains Expected_output

  Scenario: POST Statement List
    * def Expected_output = read('Response/POST_STMT_LIST_Response.json')
    Given url Baseurl + 'docimage-api/statementlist'
    And request jsonPayload2
    When method POST
    Then status 200
    * print 'response:', response
    And match response == Expected_output

  Scenario: POST Statement
    Given url Baseurl + 'docimage-api/statement'
    And request jsonPayload3
    When method POST
    Then status 200
    * print 'response:', response
