package hospital.practice.model;

import jakarta.persistence.*;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "ACTIVITY")
public class Activity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ACTIVITYID")
    private Integer activityId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ASSIGNMENTSID", nullable = false)
    private Assignment assignment;

    @Column(name = "SUBACTIVITYNAME", length = 64)
    private String subactivityName;

    @Column(name = "SUBACTIVITYDESCRIPTION", length = 256)
    private String subactivityDescription;
}
