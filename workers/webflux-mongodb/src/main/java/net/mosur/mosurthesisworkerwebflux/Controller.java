package net.mosur.mosurthesisworkerwebflux;

import lombok.AllArgsConstructor;
import net.mosur.mosurthesisworkerwebflux.entity.ThesisEntity;
import net.mosur.mosurthesisworkerwebflux.entity.EntityRepository;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;


@RestController
@RequestMapping("/")
@AllArgsConstructor
public class Controller {

    EntityRepository entityRepository;
    ThesisService thesisService;

    @GetMapping("inApp/{amount}")
    public Flux<ThesisEntity> basic(@PathVariable long amount) {
        return Flux.fromStream(thesisService.generateEntities(amount));
    }

    @GetMapping("all")
    public Flux<ThesisEntity> getEntities() {
        return entityRepository.findAll();
    }

    @GetMapping("filter/{number}")
    public Flux<ThesisEntity> filterEntities(@PathVariable("number") long number) {
        return entityRepository.findByNumber(number);
    }

    @GetMapping("one/{number}")
    public Mono<ThesisEntity> getEntity(@PathVariable("number") long number) {
        return entityRepository.findFirstByNumber(number);
    }

    @GetMapping("generate/{amount}")
    public Flux<ThesisEntity> generate(@PathVariable long amount) {
        return entityRepository.saveAll(
                Flux.fromStream(thesisService.generateEntities(amount))
        );
    }
}
