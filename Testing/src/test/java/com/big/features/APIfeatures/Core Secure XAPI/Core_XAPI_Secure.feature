@ignore
Feature: CORE_XAPI_Secured
Background:
    * def Baseurl = 'https://core-xapi.ca-c1.cloudhub.io/api/v1/c3/core-api/secure/membership/16425787/aml'
    #* def payload = {"document":{"get_account":{"account_query_definition":{"account_criteria":{"new_criteria":{"search_criteria":[{"account_identification":[{"equal":{"other":{"identification":""}}}],"account_owner":{"name":"RAMON WASTE CONSULTANTS"}}]}}},"message_header":{"creation_date_time":"2023-03-03T23:27:46.078Z","message_identification":"C1AWeTCfYQxn","request_type":{"proprietary":{"identification":"INTERAC"}}},"supplementary_data":[{"envelope":{"transaction_type":"B05"}}]}}}
 
  Scenario: Membership
  	* def Expected_output = read('/Core_MRM_Response.json')  
    Given url Baseurl
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer '+ 'eyJraWQiOiJIajFPSFBKLWFtclg2Y2Y0bnQ3QVFBLTktNzBDNUhMT2NhWGRiaVJCaEwwIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULm1uNEJUZ2NWMl9pNDB1eU9uTkhvbWVKMkpoTFNjSy1id1ljVm1ZekZDOTQiLCJpc3MiOiJodHRwczovL3NlcnZ1cy5va3RhcHJldmlldy5jb20vb2F1dGgyL2F1c3JtaGdsaHc1OFVlY0VwMGg3IiwiYXVkIjoiYXBpOi8vY29yZWFwaS1kZXYiLCJpYXQiOjE2ODQxNjE5MTAsImV4cCI6MTY4NDE2NTUxMCwiY2lkIjoiMG9hMWtveXJxazREbWV0OTEwaDgiLCJzY3AiOlsid3JpdGU6dHJhbnNhY3Rpb24iLCJyZWFkOmFjY291bnQiLCJyZWFkOnJlZmVyZW5jZSIsIndyaXRlOm1lbWJlciIsIndyaXRlOmFjY291bnQiLCJ3cml0ZTppc28yMDAyMiIsInJlYWQ6c3lzdGVtIiwicmVhZDp0cmFuc2FjdGlvbiIsInJlYWQ6cGF5bWVudCIsInJlYWQ6bWVtYmVyIiwid3JpdGU6c3lzdGVtIiwicmVhZDppc28yMDAyMiIsIndyaXRlOnBheW1lbnQiLCJ3cml0ZTpyZWZlcmVuY2UiXSwic3ViIjoiMG9hMWtveXJxazREbWV0OTEwaDgifQ.MY-bsIGi06ScIdSrV5t6QrnyArSldiy_OW5SeBCLVAOIdEUJT3uNSlDco2wenebJuhrFUbkLmc8ADecjachUV1ZzXKIfYFvD8Tk6vK3u_QeWZpngVGRnrtfiTAoQKWnoBZ73hVqUyE2qsl_RiHaqaN_pSovRjBlmxv97j9Icc567M3bx-jVaW9a7BWNjbkokccuJcL1eyZrmxKLiIPzcOkQgBx28HWfLEhjYkylWMTGVMOrhED7jN_c-tkTX1U5PVLM8N7NUpABquFm_NwJtbCWsw2WVIFfdVo44mfurnzCQRF_1AsFfy-00Cx61fLsyNWg-FdkDQWNywvFukaAOgg'
    When method GET
    Then status 200
    * print 'Response is success ', response.isSuccess