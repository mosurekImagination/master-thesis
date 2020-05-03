package net.mosur.masterthesisboot.entity;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EntityRepository extends CrudRepository<ThesisEntity, Long> {

    Iterable<ThesisEntity> findByNumber(long number);
    ThesisEntity findFirstByNumber(long number);
}
