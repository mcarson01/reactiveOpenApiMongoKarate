Feature: Testing out INSERT operations for the API

  Background:
    * url 'http://localhost:8080'

  ## This example uses inline JSON
  @Negative @All
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

  ## Example using table  
  @Positive @All
  Scenario: Create an entity with dynamic values - INSERT2
    Given path '/vendor'
	    And def companyName = faker.company().name()
	    And table payload
			| name            | position  | description                  | contactDetails                                                        |
			| companyName     | 'CEO'     | faker.company().bs()         | [{detailType: 'Office', email: 'test@test.com', phone: 303-542-8795}] |	 
	    And print 'INSERT2 - payload json\n', karate.pretty(payload[0])
    When request payload[0]
    	And method post
    Then status 200
    	And match response.name == companyName
	    And print 'response: ' + response.name

  ## Example using set
  ## Note, multiple json rows can be added to the set by replacing 'value' with an index, starting with 0
  ## example, this would be 3 rows: | path    | 0     | 1     | 2     |
  @Positive @All
  Scenario: Create an entity with dynamic values - INSERT3
    Given path '/vendor'
	    And def companyName = faker.company().name()
	    And def description = faker.company().bs()
	    And set payload
	    | path                           | value                             |
	    | name                           | companyName                       |
	    | position                       | 'CEO'                             |
	    | description                    | description                       |
	    | contactDetails[0].detailType   | 'Office'                          |
	    | contactDetails[0].email        | 'test@test.com'                   |
	    | contactDetails[0].phone        | '758-879-5564'                    |
	    And print 'INSERT3 - payload json\n', karate.pretty(payload)
    When request payload
    	And method post
    Then status 200
    	And match response.name == companyName
	    And print 'response: ' + response.name


  ## Uses data table view and
  ## showcases another way to match returned elements in list    
  @Negative @All
  Scenario: Create an entity with dynamic values - INSERT4
    Given path '/vendor'
    And table payload
		| name                       | description          |
		| faker.company().name()     | faker.company().bs() | 	 
    When request payload[0]
    	And method post
    Then status 406
	    And match response[0].code contains "contactDetails"
    