@ignore
Feature: Get cc Token

  	Scenario: Get OAuth token
  	Given url 'https://servus.oktapreview.com/oauth2/aus1ccn2361jDpKTs0h8/v1/token'
  	And header Content-Type = 'application/x-www-form-urlencoded'
  	* form field grant_type = 'client_credentials'
    * form field client_id = '0oa1ccn0xjbP4d0Sx0h8'
    * form field client_secret = 'EmASmZ-oV_7_-sc8_vrXGCcCTCIP5v3FfQ860nRO'
    * form field scope = 'read:creditlimit'
  	When method POST
  	Then status 200
  	* def tokn = response.access_token
	  * print 'Token = ', tokn
 