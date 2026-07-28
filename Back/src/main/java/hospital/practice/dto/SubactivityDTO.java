package hospital.practice.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SubactivityDTO {
    private Integer subactivityId;
    private Integer activityId;
    private ActivityDTO activity;
    private String subactivityName;
    private String subactivityDescription;
}
