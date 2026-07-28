package hospital.practice.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import hospital.practice.model.Role;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PersonDTO {
    private Integer personId;
    private String personUsername;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String personPassword;

    private String personEmail;
    private Role personRole;
    private String personName;
    private String personLastname;
}
