
Feature: Get FISSSO Token

  	Scenario: Get OAuth token
  	Given url 'https://servus.oktapreview.com/oauth2/aus1899ko4myR8t1c0h8/v1/token'
  	And header Content-Type = 'application/x-www-form-urlencoded'
  	* form field grant_type = 'client_credentials'
    * form field client_id = '0oa1899oqskmUBLGe0h8'
    * form field client_secret = 'jYhC6hDan0cPQoM6If8IEACLOgSz4S31X1F16WZ7'
    * form field scope = 'read:cards read:token'
  	When method POST
  	Then status 200
  	* def token = response.access_token
	  * print 'Token = ', token
 