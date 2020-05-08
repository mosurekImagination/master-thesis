package net.mosur.masterthesisboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.util.Random;

@SpringBootApplication
public class MasterThesisBootApplication {

	public static void main(String[] args) {
		SpringApplication.run(MasterThesisBootApplication.class, args);
	}

	@Bean
	Random random(){
		return new Random();
	}

}
