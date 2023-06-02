#Feature: Test for No Tag
  #Background:
    #* def Baseurl = ''
  #"""
  #{
  #"email": "eve.holt@reqres.in",
  #"password": "pistol"
  #}
  #"""
#
  #Scenario: Balance Enquiry
    #Given url Baseurl + '/api/credit/balances/v1/inquiry'
   #	And Postbody = read("./resources/jobEntry.json")
    #And request Postbody
    #When method POST
    #Then status 201
    #* print 'response:', response
    #
  #Scenario: Bal Enquiry with Invalid data
    #Given url Baseurl + '/api/credit/balances/v1/inquiry'
   #	And Postbody = read("./resources/jobEntry.json")
    #And request Postbody
    #When method POST
    #Then status 201
    #* print 'response:', response
#
  #Scenario: Change Cardholder Information
    #Given url Baseurl + '/api/cardmgmt/ccc/v1/updatecontactdetails'
   #	And Postbody = read("./resources/jobEntry.json")
    #And request Postbody
    #When method POST
    #Then status 201
    #* print 'response:', response    
 #
  #Scenario: Change Cardholder Information with Invalid data
    #Given url Baseurl + '/api/cardmgmt/ccc/v1/updatecontactdetails'
   #	And Postbody = read("./resources/jobEntry.json")
    #And request Postbody
    #When method POST
    #Then status 201
    #* print 'response:', response       
    #
  #Scenario: General Enquiry
    #Given url Baseurl + '/api/cardmgmt/ccc/v1/updatecontactdetails'
   #	And Postbody = read("./resources/jobEntry.json")
    #And request Postbody
    #When method POST
    #Then status 201
    #* print 'response:', response    
    #
  #Scenario: General Enquiry with Invalid data
    #Given url Baseurl + '/api/cardmgmt/ccc/v1/updatecontactdetails'
   #	And Postbody = read("./resources/jobEntry.json")
    #And request Postbody
    #When method POST
    #Then status 201
    #* print 'response:', response    
  #
  #Scenario: Credit Limit and Spend Limit
    #Given url Baseurl + '/api/cardmgmt/ccc/v1/updatecontactdetails'
   #	And Postbody = read("./resources/jobEntry.json")
    #And request Postbody
    #When method POST
    #Then status 201
    #* print 'response:', response    
    #
  #Scenario: Credit Limit and Spend Limit - with Invalid
    #Given url Baseurl + '/api/cardmgmt/ccc/v1/updatecontactdetails'
   #	And Postbody = read("./resources/jobEntry.json")
    #And request Postbody
    #When method POST
    #Then status 201
    #* print 'response:', response     
    #
  #Scenario: Add New Account
    #Given url Baseurl + '/api/cardmgmt/ccc/v1/updatecontactdetails'
   #	And Postbody = read("./resources/jobEntry.json")
    #And request Postbody
    #When method POST
    #Then status 201
    #* print 'response:', response    
    #
  #Scenario: Add New Account - with Invalid data
    #Given url Baseurl + '/api/cardmgmt/ccc/v1/updatecontactdetails'
   #	And Postbody = read("./resources/jobEntry.json")
    #And request Postbody
    #When method POST
    #Then status 201
    #* print 'response:', response     
    #
  #Scenario: Add New Account - with Invalid data
    #Given url Baseurl + '/api/credit/ccs/v1'
   #	And Postbody = read("./resources/jobEntry.json")
    #And request Postbody
    #When method PUT
    #Then status 201
    #* print 'response:', response     
#
    