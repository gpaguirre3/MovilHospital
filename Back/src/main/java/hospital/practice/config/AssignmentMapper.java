package hospital.practice.config;

import hospital.practice.dto.AssignmentDTO;
import hospital.practice.model.Assignment;
import org.mapstruct.Mapper;
import java.util.List;

@Mapper(componentModel = "spring")
public interface AssignmentMapper {
    AssignmentDTO toDTO(Assignment assignment);
    Assignment toEntity(AssignmentDTO assignmentDTO);
    List<AssignmentDTO> toDTOList(List<Assignment> assignments);
    List<Assignment> toEntityList(List<AssignmentDTO> assignmentDTOs);
}
