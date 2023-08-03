Feature: Bare features, no spring

  Scenario: test faker
    * def dataFaker = Java.type("com.github.javafaker.Faker")
    * def dataFakerObj = new dataFaker()
    * def idValue = dataFakerObj.company().name()
    * print 'idValue ' + idValue  