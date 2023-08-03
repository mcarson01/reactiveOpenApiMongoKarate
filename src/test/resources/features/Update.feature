Feature: Testing out INSERT operations for the API

  Background:
    * url 'http://localhost:8080'

  ## showcases pulling json from a file
  @Positive
  Scenario: Update non-nested element - UPDATE1
  	* def intputJson = karate.read('classpath:data/payload.json')
  	* print "request: ", intputJson
  	* def newName = "Uber Jars"
    Given path '/vendor'
    	And request intputJson
    When method post
    Then status 200
    	And print "response: ", response
    Given path '/vendor/'+response.id
	    And set intputJson.name = newName
	    And request intputJson
	    And header Content-Type = 'application/json'
	    And print "New Request", intputJson
    When method post
	Then status 200
	    And match response.name == newName


  ## showcases...
  @Positive
  Scenario: Update non-nested element - UPDATE2
    * def intputJson = karate.read('classpath:data/payload.json')
  	* print "request: ", intputJson
  	* def newName = "Uber Jars"
  	Given path '/vendor'
  		And request intputJson
    When method post
    Then status 200
    	And print "response: ", response
    Given path '/vendor/'+response.id
	    And set intputJson.name = newName
	    And request intputJson
	    And header Content-Type = 'application/json'
	    And print "New Request", intputJson
    When method post
    Then status 200
	    And match response.name == newName
    
  @Negative
  Scenario: Attempt update with invalid ID - UPDATE3
    * def intputJson = karate.read('classpath:data/payload.json')
  	* print "request: ", intputJson  
  	Given path '/vendor/xxxxxxxxxxxxxxx'
	  	And request intputJson
    When method post
    Then status 404
	    And match response[0].message == "Not Found"
  	