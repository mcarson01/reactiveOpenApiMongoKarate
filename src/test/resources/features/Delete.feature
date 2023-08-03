Feature: Testing out INSERT operations for the API

  Background:
    * url 'http://localhost:8080'

  @Negative
  Scenario: Update non-nested element - DELETE1
  	* def intputJson = karate.read('classpath:data/payload.json')
  	* print "request: ", intputJson
    Given path '/vendor/xxxxxxxxxxxxxxx'
    	And request intputJson
    When method delete
    Then status 404
		And match response[0].message == "Not Found"

  @Positive
  Scenario: Update non-nested element - DELETE2
    * def intputJson = karate.read('classpath:data/payload.json')
  	* print "request: ", intputJson
    Given path '/vendor'
    	And request intputJson
    When method post
    Then status 200
    	And print "response: ", response
    Given path '/vendor/'+response.id
    When method delete
    Then status 200
    