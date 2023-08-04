package com.wickedagile.apis.reference.reactoropenapi;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

import com.github.javafaker.Faker;
import com.intuit.karate.junit5.Karate;
import com.wickedagile.apis.reference.reactoropenapi.event.EventsConfig;

import lombok.extern.slf4j.Slf4j;

@Slf4j
class BareKarateTests {
	

	// Simple (single) test without spring, so it's much faster to run. Could be used to test commands that do not require it. 
	@Karate.Test
	Karate testGetFeatures() {
		// http://dius.github.io/java-faker/apidocs/index.html
		// Area for testing out faker library
		Faker faker = new com.github.javafaker.Faker();
		String companyName = faker.company().name();
		//////////////////////////////////////////////////////		
		return Karate.run("classpath:features/bare.feature").relativeTo(getClass());
	}

}
