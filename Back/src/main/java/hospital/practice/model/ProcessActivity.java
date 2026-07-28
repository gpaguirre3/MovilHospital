package hospital.practice.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "PROCESSACTIVITY")
public class ProcessActivity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "PROCESSACTIVITYID")
    private Integer processActivityId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PERSONID", nullable = false)
    private Person person;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "HOSPITALID", nullable = false)
    private Hospital hospital;

    @Column(name = "PROCESSACTIVITYDATESTART")
    private LocalDateTime processActivityDateStart;

    @Column(name = "PROCESSACTIVITYDATEEND")
    private LocalDateTime processActivityDateEnd;

    @Enumerated(EnumType.STRING)
    @Column(name = "PROCESSACTIVITYEVENT", length = 64)
    private ProcessActivityEvent processActivityEvent;

    @Column(name = "PROCESSACTIVITYOBSERVATION", length = 256)
    private String processActivityObservation;
}
