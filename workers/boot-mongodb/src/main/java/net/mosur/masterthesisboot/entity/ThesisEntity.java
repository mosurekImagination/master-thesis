package net.mosur.masterthesisboot.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Document
public class ThesisEntity {

    @Id
    @Field("_id")
    String id;
    Long number;
    String name;
}
