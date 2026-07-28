package hospital.practice.model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.*;
import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Embeddable
public class TimeActivityId implements Serializable {

    @Column(name = "SUBACTIVITYID")
    private Integer subactivityId;

    @Column(name = "PROCESSACTIVITYID")
    private Integer processActivityId;

    @Column(name = "TIMEACTIVITYID")
    private Integer timeActivityId;
}
