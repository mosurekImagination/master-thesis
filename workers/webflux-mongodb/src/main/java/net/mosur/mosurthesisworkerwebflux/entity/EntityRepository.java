package net.mosur.mosurthesisworkerwebflux.entity;

import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Repository
public interface EntityRepository extends ReactiveMongoRepository<ThesisEntity, String> {

    Flux<ThesisEntity> findByNumber(Long name);
    Mono<ThesisEntity> findFirstByNumber(Long name);
}
