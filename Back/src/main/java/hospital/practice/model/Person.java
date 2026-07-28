package hospital.practice.model;

import jakarta.persistence.*;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "PERSON", uniqueConstraints = {
    @UniqueConstraint(name = "UQ_PERSON_USERNAME", columnNames = "PERSONUSERNAME"),
    @UniqueConstraint(name = "UQ_PERSON_EMAIL", columnNames = "PERSONEMAIL")
})
public class Person {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "PERSONID")
    private Integer personId;

    @Column(name = "PERSONUSERNAME", length = 64, unique = true)
    private String personUsername;

    @Column(name = "PERSONPASSWORD", length = 128)
    private String personPassword;

    @Column(name = "PERSONEMAIL", length = 64, unique = true)
    private String personEmail;

    @Enumerated(EnumType.STRING)
    @Column(name = "PERSONROLE", length = 32)
    private Role personRole;

    @Column(name = "PERSONNAME", length = 64)
    private String personName;

    @Column(name = "PERSONLASTNAME", length = 64)
    private String personLastname;
}
