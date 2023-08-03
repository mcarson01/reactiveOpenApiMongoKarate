function() { 
	var url = karate.url;
	var dataFaker = Java.type("com.github.javafaker.Faker");
	
    if (!url) {
        url = 'http://localhost:8080'
    }	
	
	var config = {
		"faker": new dataFaker(),
		"requestUrl": url
	};
	
	return config;
}