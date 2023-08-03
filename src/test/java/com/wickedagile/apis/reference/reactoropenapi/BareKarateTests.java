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
	

	@Karate.Test
	Karate testGetFeatures() {
		Faker faker = new com.github.javafaker.Faker();
		String companyName = faker.company().name();
		
		return Karate.run("classpath:features/bare.feature").relativeTo(getClass());
	}

}
