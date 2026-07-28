package hospital.practice.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ActivityDTO {
    private Integer activityId;
    private Integer assignmentsId;
    private AssignmentDTO assignment;
    private String subactivityName;
    private String subactivityDescription;
}
