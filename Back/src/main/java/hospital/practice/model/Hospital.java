package hospital.practice.model;

import jakarta.persistence.*;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "HOSPITAL")
public class Hospital {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "HOSPITALID")
    private Integer hospitalId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ASSIGNMENTSID", nullable = false)
    private Assignment assignment;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PERSONID", nullable = false)
    private Person person;

    @Column(name = "HOSPITALNAME", length = 128)
    private String hospitalName;

    @Column(name = "HOSPITALDIRECTION", length = 128)
    private String hospitalDirection;

    @Column(name = "HOSPITALLATITUDE", length = 128)
    private String hospitalLatitude;

    @Column(name = "HOSPITALLONGITUDE", length = 128)
    private String hospitalLongitude;
}
