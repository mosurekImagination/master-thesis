package net.mosur.masterthesisboot;

import de.codecentric.boot.admin.server.config.EnableAdminServer;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@EnableAdminServer
@SpringBootApplication
public class MasterThesisBootApplication {

	public static void main(String[] args) {
		SpringApplication.run(MasterThesisBootApplication.class, args);
	}

}
