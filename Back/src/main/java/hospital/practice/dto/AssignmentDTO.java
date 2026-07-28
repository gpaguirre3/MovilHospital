package hospital.practice.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AssignmentDTO {
    private Integer assignmentsId;
    private String assignmentsName;
    private String assignmentsDescription;
}
