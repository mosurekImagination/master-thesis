package net.mosur.masterthesisboot.entity;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface EntityRepository extends CrudRepository<ThesisEntity, Long> {

    Iterable<ThesisEntity> findByNumber(long number);
    Optional<ThesisEntity> findFirstByNumber(long number);
}
