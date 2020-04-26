package net.mosur.masterthesisboot;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController("/")
public class Controller {

    @GetMapping("simple")
    public ResponseEntity<?> simpleEndpoint(){
        return ResponseEntity.ok().build();
    }
}
