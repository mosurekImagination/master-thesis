package net.mosur.mosurthesisworkerwebflux;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.mosur.mosurthesisworkerwebflux.entity.ThesisEntity;
import net.mosur.mosurthesisworkerwebflux.entity.EntityRepository;
import org.springframework.stereotype.Service;

import java.util.UUID;
import java.util.stream.LongStream;
import java.util.stream.Stream;

@Service
@AllArgsConstructor
@Slf4j
public class ThesisService {
    private EntityRepository entityRepository;

    public Stream<ThesisEntity> generateEntities(long amount){
        log.info("#Generating "+ amount + " entities");
        return  LongStream.range(0, amount).mapToObj(i ->
                ThesisEntity.builder()
                        .name(UUID.randomUUID().toString())
                        .number(i)
                        .build()
        );
    }
}
