package hospital.practice.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ActivityDTO {
    private Integer activityId;
    private Integer recordId;
    private RecordDTO record;
    private String activityName;
    private String activityDescription;
}
