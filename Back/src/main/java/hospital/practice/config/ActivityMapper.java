package hospital.practice.config;

import hospital.practice.dto.ActivityDTO;
import hospital.practice.model.Activity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import java.util.List;

@Mapper(componentModel = "spring", uses = {RecordMapper.class})
public interface ActivityMapper {

    @Mapping(source = "record.recordId", target = "recordId")
    ActivityDTO toDTO(Activity activity);

    @Mapping(source = "recordId", target = "record.recordId")
    Activity toEntity(ActivityDTO activityDTO);

    List<ActivityDTO> toDTOList(List<Activity> activities);
    List<Activity> toEntityList(List<ActivityDTO> activityDTOs);
}
