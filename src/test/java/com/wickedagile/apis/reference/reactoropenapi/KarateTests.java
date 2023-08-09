package com.wickedagile.apis.reference.reactoropenapi;

import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

import com.github.javafaker.Faker;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import com.wickedagile.apis.reference.reactoropenapi.event.EventsConfig;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.DEFINED_PORT)
@ContextConfiguration(classes = { OpenAPI2SpringBoot.class, EventsConfig.class })
class KarateTests {
	
	// all tests in parallel example. Adjust the threads to match the number of features.
	@Test
	public void testAllFeatures() {
		Results results = Runner.path("classpath:features").tags("All").parallel(2);
		assertTrue(results.getFailCount() == 0, results.getErrorMessages());
	}

}
