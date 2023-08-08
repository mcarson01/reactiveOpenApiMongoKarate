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

  ## Example using table  
  @Positive @SmokeTest  
  Scenario: Create an entity with dynamic values - INSERT2
    * def companyName = faker.company().name()
    * print 'companyName ' + companyName
    * table requestTable
		| name            | position  | description                  | contactDetails                                                                             |
		| companyName     | 'CEO'     | faker.company().bs()         | [{detailType: 'Office', email: 'test@test.com', phone: 303-542-8795}] |	 
    * print 'requestTable json\n', karate.pretty(requestTable[0])
    Given path '/vendor'
    When request requestTable[0]
    	And method post
    Then status 200
    	And match response.name == companyName
	    And print 'response: ' + response.name

  ## Example using set
  ## Note, multiple json rows can be added to the set by replacing 'value' with an index, starting with 0
  ## example, this would be 3 rows: | path    | 0     | 1     | 2     |
  @Positive @SmokeTest  
  Scenario: Create an entity with dynamic values - INSERT3
    * def companyName = faker.company().name()
    * def description = faker.company().bs()
    * print 'companyName ' + companyName
    * set payload
    | path                           | value                             |
    | name                           | companyName                       |
    | position                       | 'CEO'                             |
    | description                    | description                       |
    | contactDetails[0].detailType   | 'Office'                          |
    | contactDetails[0].email        | 'test@test.com'                   |
    | contactDetails[0].phone        | '758-879-5564'                    |
    * print 'payload json\n', karate.pretty(payload)
    Given path '/vendor'
    When request payload
    	And method post
    Then status 200
    	And match response.name == companyName
	    And print 'response: ' + response.name


  ## Uses data table view and
  ## showcases another way to match returned elements in list    
  @Negative @SmokeTest  
  Scenario: Create an entity with dynamic values - INSERT4
    * table requestTable
		| name                       | description          |
		| faker.company().name()     | faker.company().bs() | 	 
    Given path '/vendor'
    When request requestTable[0]
    	And method post
    Then status 406
	    And match response[0].code contains "contactDetails"
    