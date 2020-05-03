package net.mosur.mosurthesisworkerwebflux;

import lombok.Data;
import lombok.Getter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@ConfigurationProperties(prefix = "spring.r2dbc")
@Configuration
@Data
public class ConfigurationLoad {
    String url;
    String username;
    String password;
}
