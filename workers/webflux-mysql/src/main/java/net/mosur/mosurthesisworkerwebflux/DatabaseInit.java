package net.mosur.mosurthesisworkerwebflux;

import io.prometheus.client.CollectorRegistry;
import io.r2dbc.spi.ConnectionFactories;
import io.r2dbc.spi.ConnectionFactory;
import io.r2dbc.spi.ConnectionFactoryOptions;
import io.r2dbc.spi.Option;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.r2dbc.core.DatabaseClient;



@Configuration
public class DatabaseInit implements ApplicationListener<ApplicationReadyEvent> {

    @Autowired
    private ConfigurationLoad configurationLoad;

    @Override
    public void onApplicationEvent(ApplicationReadyEvent applicationReadyEvent) {
        ConnectionFactoryOptions options = ConnectionFactoryOptions.parse(configurationLoad.getUrl())
                .mutate().option(Option.valueOf("user"), configurationLoad.getUsername())
                .option(Option.valueOf("password"), configurationLoad.getPassword()).build();
        ConnectionFactory connectionFactory = ConnectionFactories.get(options);
        DatabaseClient client = DatabaseClient.create(connectionFactory);
        client.execute(
            "CREATE TABLE IF NOT EXISTS `thesis_entity` (\n" +
                    "  `id` int NOT NULL AUTO_INCREMENT,\n" +
                    "  `name` varchar(255) DEFAULT NULL,\n" +
                    "  `number` int DEFAULT NULL,\n" +
                    "  PRIMARY KEY (`id`)" +
                    ")"
        ).then().block();
    }

    @Bean(name = "importRegistry")
    public CollectorRegistry importRegistry() {
        return CollectorRegistry.defaultRegistry;
    }
}
