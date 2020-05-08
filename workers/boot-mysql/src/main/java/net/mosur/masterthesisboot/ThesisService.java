package net.mosur.masterthesisboot;

import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import net.mosur.masterthesisboot.entity.EntityRepository;
import net.mosur.masterthesisboot.entity.ThesisEntity;
import org.springframework.stereotype.Service;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Random;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.LongStream;
import java.util.stream.Stream;

@Slf4j
@Service
@AllArgsConstructor
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

    public Long fibonacci(long input) {
        if (input == 0) return 0L;
        if (input == 1) return 1L;
        if (input == 2) return 2L;
        long n1 = 1, n2 = 1, n3 = 0;
        for (long i = 2; i < input; ++i) {
            n3 = n1 + n2;
            n1 = n2;
            n2 = n3;
        }
        return n3;
    }

    public String getText() {
        return
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse non malesuada ligula, et imperdiet nisi. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Duis laoreet interdum placerat. Nam non enim non ligula blandit imperdiet. Maecenas in laoreet mauris. Aliquam eleifend est dolor. Ut dignissim lectus sed magna porta, eu auctor sapien dapibus. Pellentesque a varius quam, sit amet fermentum justo. Sed a pretium odio, vitae consequat diam. Donec non velit elit. Maecenas varius risus felis, vitae fermentum neque porttitor ac.  Sed consequat nunc est, nec varius ligula rutrum a. Etiam vulputate dui enim. Proin elementum enim sem, ac sodales lacus rutrum ac. Praesent ultricies nec massa at pharetra. Praesent blandit mi sed sem mattis, id semper felis tincidunt. Sed vehicula cursus justo, vitae feugiat est. Quisque ut tortor mollis, viverra nisl vitae, laoreet dolor. Cras non eros cursus, pulvinar eros nec, feugiat ipsum. Nullam non odio at velit malesuada consequat non vitae augue. Praesent tristique mauris vitae leo lobortis viverra. Suspendisse potenti. Aenean lorem libero, consequat eget lacus et, fringilla pretium enim. Nulla facilisi. Nam vestibulum vulputate elit sed facilisis. Donec a varius magna. Proin vestibulum vehicula quam, dictum ullamcorper risus consequat ac. Donec pulvinar sapien tempus odio malesuada pretium. Interdum et malesuada fames ac ante ipsum primis in faucibus. Cras aliquam eget velit sit amet tincidunt. Donec tempor risus id mi viverra tempor sit amet ut felis. Aenean imperdiet commodo scelerisque. Mauris suscipit molestie nisi hendrerit ornare. Mauris massa risus, egestas condimentum bibendum in, laoreet ac libero. Curabitur sed ipsum porttitor, blandit libero nec, porta tortor. Pellentesque id massa tellus. Morbi aliquam risus non sapien malesuada laoreet. Nulla porta ante a ante aliquet viverra. In ornare felis gravida, pharetra nibh sit amet, euismod dui. Aenean eu sollicitudin nulla, vel porttitor tortor. Donec ut arcu vitae erat lacinia cursus. Vestibulum et nisl ultricies, blandit quam eget, pretium sem. Donec dui dui, blandit ut tempor non, pellentesque et lorem. Morbi feugiat nec felis eget venenatis. Mauris et elit sed ex eleifend malesuada ut eget ex. Nulla auctor nec lacus et tincidunt. Ut iaculis dapibus laoreet.s";
    }

    @SneakyThrows
    public String getFile() {
        return Files.newBufferedReader(
                Paths.get("app/file.txt"))
                .lines()
                .map(String::toUpperCase)
                .collect(Collectors.joining());
    }

    public Stream<ThesisEntity> generateSomeEntities(long amount, int range) {
        return LongStream.range(0, amount).mapToObj(i ->
                ThesisEntity.builder()
                        .name(UUID.randomUUID().toString())
                        .number((long) random.nextInt(range))
                        .build());
    }
}
