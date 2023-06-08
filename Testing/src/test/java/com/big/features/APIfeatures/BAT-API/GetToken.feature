@ignore
Feature: Get BAT Token

  Scenario: Get OAuth token
    Given url 'https://servus.oktapreview.com/oauth2/ausueumpiiGvFt8ka0h7/v1/token'
    And header Content-Type = 'application/x-www-form-urlencoded'
    * form field grant_type = 'client_credentials'
    * form field client_id = '0oatr08bv8ZxzZxOd0h7'
    * form field client_secret = 'b-zUTFdSejKUx5P3hl_78xjNA3tpTduDLWLzSkad'
    * form field scope = 'submission'
    When method POST
    Then status 200
    * def token = response.access_token
    * print 'Token = ', token
