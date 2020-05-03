package net.mosur.masterthesisboot.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Builder
public class ThesisEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.TABLE)
    Long id;
    Long number;
    String name;
}
