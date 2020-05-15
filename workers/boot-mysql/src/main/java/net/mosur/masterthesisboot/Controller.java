package net.mosur.masterthesisboot;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import net.mosur.masterthesisboot.entity.EntityRepository;
import net.mosur.masterthesisboot.entity.ThesisEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigInteger;
import java.util.Random;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@RestController
@RequestMapping("/")
@AllArgsConstructor
@Log4j2
public class Controller {

    private final EntityRepository entityRepository;
    private final ThesisService thesisService;
    private final Random random;


    @GetMapping("inApp/{amount}")
    public Iterable<ThesisEntity> basic(@PathVariable long amount) {
        log.info("inApp");
        return thesisService.generateEntities(amount)
                .collect(Collectors.toList());
    }

    @GetMapping("fibonacci/{input}")
    public BigInteger fibonacci(@PathVariable long input) {
        log.info("fibonacci");
        return thesisService.fibonacci(input);
    }

    @GetMapping("read-text")
    public String getText() {
        log.info("read-text");
        return thesisService.getText();
    }

    @GetMapping("fib/{input}/find-one/{number}")
    public ThesisEntity fibonacciAndThenFindOne(@PathVariable long input,
                                                @PathVariable long number) {
        log.info("fibonacci-and-then-find-one");
        thesisService.fibonacci(input);
        return entityRepository.findFirstByNumber(number).get();
    }

    @GetMapping("read-file")
    public String getFile() {
        log.info("read-file");
        return thesisService.getFile();
    }

    @GetMapping("all")
    public Iterable<ThesisEntity> getEntities() {
        log.info("all");
        return entityRepository.findAll();
    }
    @GetMapping("filter/{number}")
    public Iterable<ThesisEntity> filterEntities(@PathVariable("number") long number) {
        log.info("filer");
        return entityRepository.findByNumber(number);
    }

    @GetMapping("generate-some/{amount}/{range}")
    public Iterable<ThesisEntity> generateSome(@PathVariable long amount, @PathVariable int range) {
        log.info("generate-some");
        return entityRepository.saveAll(thesisService.generateSomeEntities(amount,range)::iterator);
    }

    @GetMapping("find-one/{number}")
    public ThesisEntity getEntity(@PathVariable("number") long number) {
        log.info("find-one");
        return entityRepository.findFirstByNumber(number).get();
    }

    @GetMapping("generate-one/{range}")
    public ThesisEntity generate(@PathVariable int range) {
        log.info("generate-one");
        return entityRepository.save(thesisService.generateEntity(range));
    }

    @GetMapping("generate/{amount}")
    public Iterable<ThesisEntity> generate(@PathVariable long amount) {
        log.info("generating " + amount);
        return entityRepository.saveAll(thesisService.generateEntities(amount)::iterator);
    }

    @GetMapping("modify-one/{number}/{range}")
    public ThesisEntity generate(@PathVariable long number, @PathVariable int range) {
        log.info("modify-one");
        return entityRepository.findFirstByNumber(number).map(e ->
        {
            e.setNumber((long)random.nextInt(range));
            entityRepository.save(e);
            return e;
        }).get();
    }

    @GetMapping("clear-database")
    public void clearDatabase() {
        log.info("clearing-database");
        entityRepository.deleteAll();
    }
}
