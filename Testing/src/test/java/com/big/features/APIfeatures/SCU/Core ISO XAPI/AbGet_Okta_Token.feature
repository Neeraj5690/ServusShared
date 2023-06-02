@ignore
Feature: CORE_ISO_XAPI
Background:
    * def Baseurl = 'https://servus.oktapreview.com/oauth2/ausrmhglhw58UecEp0h7/v1/token'
    
  Scenario: Get OKTA dev Token
    #* def payload =
    #"""
    #{"client_id": "0oa1koyrqk4Dmet910h8","client_secret": "y0vDn0xdDxU0r7UXe5S41smktYjZoFn1WIHvNsXi","grant_type": "client_credentials"}
    #"""
    Given url Baseurl
    And header Content-Type = 'application/x-www-form-urlencoded'
    And form field client_id = '0oa1koyrqk4Dmet910h8'
    And form field client_secret = 'y0vDn0xdDxU0r7UXe5S41smktYjZoFn1WIHvNsXi'
    And form field grant_type = 'client_credentials'
    #And request payload
    When method POST
    Then status 200
    * print 'response:', response
    
 