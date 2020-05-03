package net.mosur.masterthesisboot;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.mosur.masterthesisboot.entity.EntityRepository;
import net.mosur.masterthesisboot.entity.ThesisEntity;
import org.springframework.stereotype.Service;

import java.util.UUID;
import java.util.stream.LongStream;
import java.util.stream.Stream;

@Slf4j
@Service
@AllArgsConstructor
public class ThesisService {
    private final EntityRepository entityRepository;

    public Stream<ThesisEntity> generateEntities(long amount) {
        log.info("#Generating " + amount + " entities");
        return LongStream.range(0, amount).mapToObj(i ->
                ThesisEntity.builder()
                        .name(UUID.randomUUID().toString())
                        .number(i)
                        .build()
        );
    }
}
