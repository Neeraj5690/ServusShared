@ignore
Feature: FISSSO XAPI
Background:
    * def Baseurl = 'https://fissso-xapi.ca-c1.cloudhub.io/api/v1/'
 
  Scenario: Get Cards...
		* def Expected_output = read('/Get_cards_Response.json') 
		#* def Expected_output = {"messages": [],"apiVersionNumber": "1.0.0.0","isSuccess": true,"response": [{"pan": "7126"},{"pan": "9494"}],"timestamp": "2023-04-25T01:25:08.4990088-06:00","referenceNumber": null} 
  	#* def result = call read(../Village Branch Service XAPI/Village_Branch_XAPI.feature)
  	Given url Baseurl + 'getcards/sso?partyId=430068'
    And header Authorization = 'Bearer eyJraWQiOiJzY1RkUUgwLUVPa2xnSm1mVjdPZ1lOMTlkTXBZV0dOOWQydFlabXdtOHQ0IiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULl85SDFuSVE0VjRLc1BxQjN6Y09SeHJEMFZDWE5IaWtKd2N4NDBKeTlkbkUiLCJpc3MiOiJodHRwczovL3NlcnZ1cy5va3RhcHJldmlldy5jb20vb2F1dGgyL2F1czE4OTlrbzRteVI4dDFjMGg4IiwiYXVkIjoiYXBpOi8vZmlzc3NvLWRldiIsImlhdCI6MTY4MzAxOTE2OSwiZXhwIjoxNjgzMDIyNzY5LCJjaWQiOiIwb2ExODk5b3Fza21VQkxHZTBoOCIsInNjcCI6WyJyZWFkOmNhcmRzIiwicmVhZDp0b2tlbiJdLCJzdWIiOiIwb2ExODk5b3Fza21VQkxHZTBoOCJ9.FhZUkDS9luw1U5pU8PU9_baj5FNwuYEXne6zxC29Jb9EPOXqhbIBxzsVJV1ACFrs9Kx4no6hCCCXRBW0pSOr2hkY-SBjCSqXfyj9BNOpjE5Ynzbt0SoUFa2waPZ0eNcCeKl6NYFmZUmpqiywcul-idgQXjNZOsg5JM_h_6xWV2qz3QqNr94-ORzk_fRTpzmXdeh0BXNMk3xwLv0PsUknL_042MEEj_Mo3gwo__RP1C4Qox_kHG6grXOI6KaycVDFSMBjeXgwUzso3vcAExykNvRAwuxOCaY5FYd5AeLYUjy0P3jdxRqojiTecFecnM8v5NamLfZFRfqowyYbzYVk5g$#!$%#%$!#!'
    When method GET
    #Then match responseStatus == 200
    #* def testAddress = karate.fromString(response)
		#And string string_type = response[0]
    Then status 200
    * print 'response:', response.isSuccess
    #* print 'Respo', response
    #And match response contains Expected_output
    
  Scenario: Get SSO Token
		* def Expected_output = read('/Get_SSO_Token_Response.json')  
  	#* def result = call read(../Village Branch Service XAPI/Village_Branch_XAPI.feature)
  	Given url Baseurl + 'ssotoken?partyId=430068&ccNumber=9494&email=joe@servus.ca'
    And header Authorization = 'Bearer eyJraWQiOiJzY1RkUUgwLUVPa2xnSm1mVjdPZ1lOMTlkTXBZV0dOOWQydFlabXdtOHQ0IiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULl85SDFuSVE0VjRLc1BxQjN6Y09SeHJEMFZDWE5IaWtKd2N4NDBKeTlkbkUiLCJpc3MiOiJodHRwczovL3NlcnZ1cy5va3RhcHJldmlldy5jb20vb2F1dGgyL2F1czE4OTlrbzRteVI4dDFjMGg4IiwiYXVkIjoiYXBpOi8vZmlzc3NvLWRldiIsImlhdCI6MTY4MzAxOTE2OSwiZXhwIjoxNjgzMDIyNzY5LCJjaWQiOiIwb2ExODk5b3Fza21VQkxHZTBoOCIsInNjcCI6WyJyZWFkOmNhcmRzIiwicmVhZDp0b2tlbiJdLCJzdWIiOiIwb2ExODk5b3Fza21VQkxHZTBoOCJ9.FhZUkDS9luw1U5pU8PU9_baj5FNwuYEXne6zxC29Jb9EPOXqhbIBxzsVJV1ACFrs9Kx4no6hCCCXRBW0pSOr2hkY-SBjCSqXfyj9BNOpjE5Ynzbt0SoUFa2waPZ0eNcCeKl6NYFmZUmpqiywcul-idgQXjNZOsg5JM_h_6xWV2qz3QqNr94-ORzk_fRTpzmXdeh0BXNMk3xwLv0PsUknL_042MEEj_Mo3gwo__RP1C4Qox_kHG6grXOI6KaycVDFSMBjeXgwUzso3vcAExykNvRAwuxOCaY5FYd5AeLYUjy0P3jdxRqojiTecFecnM8v5NamLfZFRfqowyYbzYVk5g $#!$%#%$!#!'
    When method GET
    Then match responseStatus == 200
    * print 'response:', response.isSuccess
    And string string_type = response
    * print 'responses:' , string_type
