package net.mosur.mosurthesisworkerwebflux;

import io.netty.util.ReferenceCounted;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import net.mosur.mosurthesisworkerwebflux.entity.EntityRepository;
import net.mosur.mosurthesisworkerwebflux.entity.ThesisEntity;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.netty.ByteBufFlux;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.util.Random;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.LongStream;
import java.util.stream.Stream;

import static reactor.netty.ByteBufFlux.fromPath;

@Service
@RequiredArgsConstructor
@Slf4j
public class ThesisService {
    private final EntityRepository entityRepository;
    private final Random random;
    private final String FILE_PATH = "files/file.txt";

    public Stream<ThesisEntity> generateEntities(long amount) {
        return LongStream.range(0, amount).mapToObj(i ->
                ThesisEntity.builder()
                        .name(UUID.randomUUID().toString())
                        .number(i)
                        .build()
        );
    }

    public ThesisEntity generateEntity(int numberRange) {
        return ThesisEntity.builder()
                .name(UUID.randomUUID().toString())
                .number((long) random.nextInt(numberRange))
                .build();
    }

    public Mono<BigInteger> fibonacci(long input) {
        if (input == 0) return Mono.just(BigInteger.ZERO);
        if (input == 1) return Mono.just(BigInteger.ONE);
        if (input == 2) return Mono.just(BigInteger.valueOf(2));
        BigInteger n1 = BigInteger.ONE, n2 = BigInteger.ONE, n3 = BigInteger.ZERO;
        for (long i = 2; i < input; ++i) {
            n3 = n1.add(n2);
            n1 = n2;
            n2 = n3;
        }
        return Mono.just(n3);
    }

    public Mono<String> getText() {
        return Mono.just(TEXT);
    }

    @SneakyThrows
    public Flux<String> getFile() {
        ByteBufFlux byteBufFlux = fromPath(
                Paths.get("/app/file.txt")
        );
        Flux<String> text = byteBufFlux
                .asString(StandardCharsets.UTF_8)
                .map(String::toUpperCase);
        byteBufFlux.map(ReferenceCounted::release);
        return text;
    }

    public Stream<ThesisEntity> generateSomeEntities(long amount, int range) {
        return LongStream.range(0, amount).mapToObj(i ->
                ThesisEntity.builder()
                        .name(UUID.randomUUID().toString())
                        .number((long) random.nextInt(range))
                        .build());
    }

    private static final String TEXT = IntStream.range(0,1000)
            .mapToObj(e -> getParagraph())
            .collect(Collectors.joining());

    public static String getParagraph() {
        return "Proin vehicula augue id massa congue pretium. Nunc posuere velit " +
                "et tristique lobortis. Etiam pharetra, odio quis cursus lacinia, " +
                "ipsum felis pharetra mi, vitae facilisis nisl eros sed lacus. " +
                "Duis lacinia porta sapien vitae hendrerit. Aliquam dignissim ante nisl," +
                "sed fermentum elit facilisis at. Class aptent taciti sociosqu " +
                "ad litora torquent per conubia nostra, per inceptos himenaeos. " +
                "Cras lorem nibh, sollicitudin non eros et, suscipit tempus massa. " +
                "Integer elementum erat interdum, eleifend elit non, aliquam nulla." +
                " Pellentesque habitant morbi tristique senectus et netus et malesuada" +
                " fames ac turpis egestas. Pellentesque habitant morbi tristique senectus" +
                " et netus et malesuada fames ac turpis egestas. ";
    }
}
