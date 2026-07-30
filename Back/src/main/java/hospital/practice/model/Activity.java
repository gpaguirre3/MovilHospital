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
    @JoinColumn(name = "RECORDID", nullable = false)
    private Record record;

    @Column(name = "ACTIVITYNAME", length = 64)
    private String activityName;

    @Column(name = "ACTIVITYDESCRIPTION", length = 256)
    private String activityDescription;
}
