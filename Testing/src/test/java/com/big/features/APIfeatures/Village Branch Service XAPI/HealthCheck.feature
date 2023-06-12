
Feature: Village BranchService | Health Check
Background:
    * def Baseurl = 'https://village-branch-directory-xapi.ca-c1.cloudhub.io/api/v1'
    * def subpath = '/healthcheck'
    
    # Getting Token Data
    #* def resp = call read('GetToken.feature')
    #* def token = resp.token
    
    # Reading Saved Data
    * def jsonPayload = read('SavedData.json')
    * def apiName = jsonPayload.apiName
   	* def status = jsonPayload.status
   
    # Printing saved data
    * print apiName
    * print status
    
       
  # 1 Mule API response with valid input
  Scenario: 1 Check for Mule API response with valid input
    Given url Baseurl + subpath
    #And header Authorization = 'Bearer '+ token
    When method GET
    Then status 200
   

  	# 2 Mule API response contains API Name and Health Status
  Scenario: 2 Check for response and compare same with layer 7 for valid parameter -[None]
    Given url Baseurl + subpath
    When method GET
    * print 'response:', response
    Then status 200 
  		# Getting Mule Response
    * def MuleResponse_apiName = response['apiName']
    * print MuleResponse_apiName
    * def MuleResponse_status = response['status']
    * print MuleResponse_status
    
    # Matching response data
    * match apiName == MuleResponse_apiName   
    * match status == MuleResponse_status
