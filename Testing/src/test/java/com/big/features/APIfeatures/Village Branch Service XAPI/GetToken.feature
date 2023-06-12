Feature: Get Village Branch Token

  Scenario: Get OAuth token
    Given url 'https://servus.oktapreview.com/oauth2/aus1ccn2361jDpKTs0h8/v1/token'
    And header Content-Type = 'application/x-www-form-urlencoded'
    * form field grant_type = 'client_credentials'
    * form field client_id = '0oa1cxmj22kZ2nQZ70h8'
    * form field client_secret = 'WHMo-EfKWR_XeJlX1hNy2s9XIMGXbE0nKSX7KQjG'
    * form field scope = 'read:account'
    When method POST
    Then status 200
    * def token = response.access_token
    * print 'Token = ', token
