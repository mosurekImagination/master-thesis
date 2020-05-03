package net.mosur.mosurthesisworkerwebflux.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ThesisEntity {

    @Id
    Long id;
    Long number;
    String name;
}
