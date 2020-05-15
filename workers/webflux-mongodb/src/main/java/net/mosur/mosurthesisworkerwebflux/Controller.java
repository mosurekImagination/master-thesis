package net.mosur.mosurthesisworkerwebflux;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import net.mosur.mosurthesisworkerwebflux.entity.ThesisEntity;
import net.mosur.mosurthesisworkerwebflux.entity.EntityRepository;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.math.BigInteger;
import java.util.Random;


@RestController
@RequestMapping("/")
@AllArgsConstructor
@Log4j2
public class Controller {

    private final EntityRepository entityRepository;
    private final ThesisService thesisService;
    private final Random random;

    @GetMapping("inApp/{amount}")
    public Flux<ThesisEntity> basic(@PathVariable long amount) {
        log.info("inApp");
        return Flux.fromStream(thesisService.generateEntities(amount));
    }

    @GetMapping("fibonacci/{input}")
    public Mono<BigInteger> fibonacci(@PathVariable long input) {
        log.info("fibonacci");
        return thesisService.fibonacci(input);
    }

    @GetMapping("read-text")
    public Mono<String> getText() {
        log.info("read-text");
        return thesisService.getText();
    }

    @GetMapping("fib/{input}/find-one/{number}")
    public Mono<ThesisEntity> fibonacciAndThenFindOne(@PathVariable long input,
                                                      @PathVariable long number) {
        log.info("fibonacci-and-then-find-one");
        thesisService.fibonacci(input);
        return entityRepository.findFirstByNumber(number);
    }

    @GetMapping("read-file")
    public Flux<String> getFile() {
        log.info("read-file");
        return thesisService.getFile();
    }

    @GetMapping("all")
    public Flux<ThesisEntity> getEntities() {
        log.info("all");
        return entityRepository.findAll();
    }

    @GetMapping("filter/{number}")
    public Flux<ThesisEntity> filterEntities(@PathVariable("number") long number) {
        log.info("filer");
        return entityRepository.findByNumber(number);
    }

    @GetMapping("generate/{amount}")
    public Flux<ThesisEntity> generate(@PathVariable long amount) {
        log.info("generate");
        return entityRepository.saveAll(
                Flux.fromStream(thesisService.generateEntities(amount))
        );
    }

    @GetMapping("generate-some/{amount}/{range}")
    public Flux<ThesisEntity> generateSome(@PathVariable long amount, @PathVariable int range) {
        log.info("generate-some");
        return entityRepository.saveAll(
                Flux.fromStream(thesisService.generateSomeEntities(amount,range))
        );
    }

    @GetMapping("find-one/{number}")
    public Mono<ThesisEntity> getEntity(@PathVariable("number") long number) {
        log.info("find-one");
        return entityRepository.findFirstByNumber(number);
    }

    @GetMapping("generate-one/{range}")
    public Mono<ThesisEntity> generate(@PathVariable int range) {
        log.info("generate-one");
        return entityRepository.save(thesisService.generateEntity(range));
    }

    @GetMapping("modify-one/{number}/{range}")
    public Mono<ThesisEntity> generate(@PathVariable long number, @PathVariable int range) {
        log.info("modify-one");
        return entityRepository.findFirstByNumber(number).map(e ->
        {
            e.setNumber((long)random.nextInt(range));
            entityRepository.save(e);
            return e;
        });
    }

    @GetMapping("clear-database")
    public Mono<Void> clearDatabase() {
        log.info("clearing-database");
        return entityRepository.deleteAll();
    }

}
