Feature: Testing out INSERT operations for the API

  Background:
    * url 'http://localhost:8080'

  ## showcases pulling json from a file
  @Positive @Smoke @All
  Scenario: Update non-nested element - UPDATE1
    Given path '/vendor'
    	And def payload = karate.read('classpath:data/payload.json')
    	And print "UPDATE1 - payload: ", payload
    	And request payload
    When method post
    Then status 200
    	And print "UPDATE1 - response: ", response
    * print "UPDATE1 - Starting new request..."
    Given path '/vendor/'+response.id
	    And def newName = "Uber Jars"
	    And set payload.name = newName
	    And request payload
	    And header Content-Type = 'application/json'
	    And print "UPDATE1 - New Request", payload
    When method post
	Then status 200
	    And match response.name == newName


  ## showcases...
  @Positive @All
  Scenario: Update non-nested element - UPDATE2
  	Given path '/vendor'
  		And def payload = karate.read('classpath:data/payload.json')
  		And print "UPDATE2 - payload: ", payload
  		And request payload
    When method post
    Then status 200
    	And print "UPDATE2 - response: ", response
    Given path '/vendor/'+response.id
	    And def newName = "Uber Jars"
	    And set payload.name = newName
	    And request payload
	    And header Content-Type = 'application/json'
	    And print "UPDATE2 - New Request", payload
    When method post
    Then status 200
	    And match response.name == newName
    
  @Negative @All
  Scenario: Attempt update with invalid ID - UPDATE3 
  	Given path '/vendor/xxxxxxxxxxxxxxx'
  		And def payload = karate.read('classpath:data/payload.json')
  		And print "UPDATE3 - payload: ", payload
	  	And request payload
    When method post
    Then status 404
	    And match response[0].message == "Not Found"
  	