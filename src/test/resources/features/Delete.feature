Feature: Testing out INSERT operations for the API

  Background:
    * url 'http://localhost:8080'

  @Negative
  Scenario: Update non-nested element - DELETE1
    Given path '/vendor/xxxxxxxxxxxxxxx'
    	And def payload = karate.read('classpath:data/payload.json')
    	And print "DELETE1 - payload: ", payload
    	And request payload
    When method delete
    Then status 404
		And match response[0].message == "Not Found"

  @Positive
  Scenario: Update non-nested element - DELETE2
    Given path '/vendor'
    	And def payload = karate.read('classpath:data/payload.json')
    	And print "DELETE2 - payload: ", payload
    	And request payload
    When method post
    Then status 200
    	And print "response: ", response
    Given path '/vendor/'+response.id
    When method delete
    Then status 200
    