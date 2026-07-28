package hospital.practice.model;

import jakarta.persistence.*;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "ASSIGNMENTS")
public class Assignment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ASSIGNMENTSID")
    private Integer assignmentsId;

    @Column(name = "ASSIGNMENTSNAME", length = 128)
    private String assignmentsName;

    @Column(name = "ASSIGNMENTSDESCRIPTION", length = 256)
    private String assignmentsDescription;
}
