package hospital.practice.dto;

import hospital.practice.model.ProcessActivityEvent;
import lombok.*;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProcessActivityDTO {
    private Integer processActivityId;
    private Integer personId;
    private PersonDTO person;
    private Integer hospitalId;
    private HospitalDTO hospital;
    private LocalDateTime processActivityDateStart;
    private LocalDateTime processActivityDateEnd;
    private ProcessActivityEvent processActivityEvent;
    private String processActivityObservation;
}
