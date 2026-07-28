package hospital.practice.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TimeActivityDTO {
    private Integer subactivityId;
    private Integer processActivityId;
    private Integer timeActivityId;
    private SubactivityDTO subactivity;
    private ProcessActivityDTO processActivity;
}
