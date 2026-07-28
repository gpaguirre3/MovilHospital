package hospital.practice.model;

import jakarta.persistence.*;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "SUBACTIVITY")
public class Subactivity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "SUBACTIVITYID")
    private Integer subactivityId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ACTIVITYID", nullable = false)
    private Activity activity;

    @Column(name = "SUBACTIVITYNAME", length = 64)
    private String subactivityName;

    @Column(name = "SUBACTIVITYDESCRIPTION", length = 256)
    private String subactivityDescription;
}
