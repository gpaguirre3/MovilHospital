package hospital.practice.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RecordDTO {
    private Integer recordId;
    private String recordName;
    private String recordDescription;
    private Integer assignmentsId;
    private AssignmentDTO assignment;
}
