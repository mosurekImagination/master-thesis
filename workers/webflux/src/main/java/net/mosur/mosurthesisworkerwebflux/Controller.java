package net.mosur.mosurthesisworkerwebflux;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
public class Controller {

    @GetMapping("/simple")
    public ResponseEntity<?> simple(){
        return ResponseEntity.ok().build();
    }
}
