package net.mosur.mosurthesisworkerwebflux.entity;

import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Repository
public interface EntityRepository extends ReactiveCrudRepository<ThesisEntity, String> {

    Flux<ThesisEntity> findByNumber(Long name);

    Mono<ThesisEntity> findFirstByNumber(Long name);
}
