package hospital.practice.config;

import hospital.practice.dto.ActivityDTO;
import hospital.practice.model.Activity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import java.util.List;

@Mapper(componentModel = "spring", uses = {AssignmentMapper.class})
public interface ActivityMapper {

    @Mapping(source = "assignment.assignmentsId", target = "assignmentsId")
    ActivityDTO toDTO(Activity activity);

    @Mapping(source = "assignmentsId", target = "assignment.assignmentsId")
    Activity toEntity(ActivityDTO activityDTO);

    List<ActivityDTO> toDTOList(List<Activity> activities);
    List<Activity> toEntityList(List<ActivityDTO> activityDTOs);
}
