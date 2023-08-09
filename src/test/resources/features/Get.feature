Feature: Testing out GET operations for the API

  Background:
    * url 'http://localhost:8080'

  @Negative @All
  Scenario: Can't find the entity - GET1
    Given path '/vendor/XXXXXX'
    When method Get
    Then status 404
    
  @Positive @Smoke @All
  Scenario: Found the entity - GET2
    Given path '/vendor'
    When request 
	    """
	    {
	    	name: 'Widgets Incorporated', 
	    	description: 'They are a widget company!', 
	    	contactDetails: [
	    		{
	    			detailType: 'Office', 
	    			email: 'test@test.com', 
	    			phone: '617-879-8798'
	    		}
	    	]
	    }
	    """
    	And method post
    Then status 200
    Given path '/vendor/'+response.id
    When method get
    Then status 200
    