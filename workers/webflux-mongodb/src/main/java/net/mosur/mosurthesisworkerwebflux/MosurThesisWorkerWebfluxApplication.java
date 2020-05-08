package net.mosur.mosurthesisworkerwebflux;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.util.Random;

@SpringBootApplication
public class MosurThesisWorkerWebfluxApplication {

	public static void main(String[] args) {
		SpringApplication.run(MosurThesisWorkerWebfluxApplication.class, args);
	}


	@Bean
	Random random(){
		return new Random();
	}
}
