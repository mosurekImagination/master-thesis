package net.mosur.masterthesisboot;

import lombok.AllArgsConstructor;
import net.mosur.masterthesisboot.entity.ThesisEntity;
import net.mosur.masterthesisboot.entity.EntityRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.stream.Collectors;

@RestController
@RequestMapping("/")
@AllArgsConstructor
public class Controller {

    EntityRepository entityRepository;
    ThesisService thesisService;

    @GetMapping("inApp/{amount}")
    public Iterable<ThesisEntity> basic(@PathVariable long amount) {
        return thesisService.generateEntities(amount).collect(Collectors.toList());
    }

    @GetMapping("all")
    public Iterable<ThesisEntity> getEntities() {
        return entityRepository.findAll();
    }

    @GetMapping("filter/{number}")
    public Iterable<ThesisEntity> filterEntities(@PathVariable("number") long number) {
        return entityRepository.findByNumber(number);
    }

    @GetMapping("one/{number}")
    public ThesisEntity getEntity(@PathVariable("number") long number) {
        return entityRepository.findFirstByNumber(number);
    }

    @GetMapping("generate/{amount}")
    public Iterable<ThesisEntity> generate(@PathVariable long amount) {
        return entityRepository.saveAll(thesisService.generateEntities(amount)
                .collect(Collectors.toList()));
    }
}
