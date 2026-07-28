package hospital.practice.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class HospitalDTO {
    private Integer hospitalId;
    private Integer assignmentsId;
    private AssignmentDTO assignment;
    private Integer personId;
    private PersonDTO person;
    private String hospitalName;
    private String hospitalDirection;
    private String hospitalLatitude;
    private String hospitalLongitude;
}
