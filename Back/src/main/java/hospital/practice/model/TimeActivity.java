package hospital.practice.model;

import jakarta.persistence.*;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "TIMEACTIVITY")
public class TimeActivity {

    @EmbeddedId
    private TimeActivityId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("subactivityId")
    @JoinColumn(name = "SUBACTIVITYID", nullable = false)
    private Subactivity subactivity;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("processActivityId")
    @JoinColumn(name = "PROCESSACTIVITYID", nullable = false)
    private ProcessActivity processActivity;
}
