package com.wickedagile.apis.reference.reactoropenapi;

import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.wickedagile.apis.reference.reactoropenapi.event.EventsConfig;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.DEFINED_PORT)
@ContextConfiguration(classes = { OpenAPI2SpringBoot.class, EventsConfig.class })
class KarateTests {

	@Value("${server.port}")
	private int serverPort;

	@Value("${test.expected.deletes}")
	int expectedDeletes;

	@Value("${test.expected.updates}")
	int expectedUpdates;

	@Value("${test.expected.inserts}")
	int expectedInserts;

	@Value("${test.expected.reads}")
	int expectedReads;
	
	
	@Test
	public void testAllFeatures() {
		Results results = Runner.path("classpath:features").parallel(5);
		assertTrue(results.getFailCount() == 0, results.getErrorMessages());
	}

	/*
	@Karate.Test
	Karate testGetFeatures() {
		// http://dius.github.io/java-faker/apidocs/index.html
		Faker faker = new com.github.javafaker.Faker();
		String companyName = faker.company().name();
		log.info("server port: "+ serverPort);
		
		return Karate.run("Get").relativeTo(getClass());
	}


	@Karate.Test
	Karate testInsertFeatures() {
	    return Karate.run("Insert").relativeTo(getClass());
	}
	
	@Karate.Test
	Karate testUpdateFeatures() {
	    return Karate.run("Update").relativeTo(getClass());
	}

	@Karate.Test
	Karate testDeleteFeatures() {
	    return Karate.run("Delete").relativeTo(getClass());
	}	
*/	
}
