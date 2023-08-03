Feature: Testing out INSERT operations for the API

  Background:
    * url 'http://localhost:8080'

  ## This example uses inline JSON
  @Negative
  Scenario: Insert fails, invalid email
    Given path '/vendor'
    When request 
	    """
	    {
	    	name: '#(faker.company().name())', 
	    	position: 'CEO', 
	    	description: 'They are a widget company!', 
	    	contactDetails: [
	    		{
	    			detailType: 'Office', 
	    			email: 'test@', 
	    			phone: '#(faker.company().phoneNumber())'
	    		}
	    	]
	    }
	    """
	    And method post
    Then status 406
    	And match response[0].code == "contactDetails[].email"

    
  @Positive @SmokeTest  
  Scenario: Create an entity with dynamic values - INSERT2
    * def companyName = faker.company().name()
    * print 'companyName ' + companyName
    * table requestTable
		| name            | position  | description                  | contactDetails                                                                         |
		| companyName     | 'CEO'     | faker.company().bs()         | [{detailType: 'Office', email: 'test@test.com', phone: faker.company().phoneNumber()}] |	 
    * print 'requestTable json\n', karate.pretty(requestTable)
    Given path '/vendor'
    When request requestTable[0]
    	And method post
    Then status 200
    	And match response.name == '#(companyName)'
	    And print 'response: ' + response.name

  ## Uses data table view and
  ## showcases another way to match returned elements in list    
  @Negative @SmokeTest  
  Scenario: Create an entity with dynamic values - INSERT3
    * table requestTable
		| name                       | description          |
		| faker.company().name()     | faker.company().bs() | 	 
    Given path '/vendor'
    When request requestTable[0]
    	And method post
    Then status 406
	    And match response[0].code contains "contactDetails"
    