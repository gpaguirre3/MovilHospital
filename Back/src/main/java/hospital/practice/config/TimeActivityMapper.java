package hospital.practice.config;

import hospital.practice.dto.TimeActivityDTO;
import hospital.practice.model.TimeActivity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import java.util.List;

@Mapper(componentModel = "spring", uses = {SubactivityMapper.class, ProcessActivityMapper.class})
public interface TimeActivityMapper {

    @Mapping(source = "id.subactivityId", target = "subactivityId")
    @Mapping(source = "id.processActivityId", target = "processActivityId")
    @Mapping(source = "id.timeActivityId", target = "timeActivityId")
    TimeActivityDTO toDTO(TimeActivity timeActivity);

    @Mapping(source = "subactivityId", target = "id.subactivityId")
    @Mapping(source = "processActivityId", target = "id.processActivityId")
    @Mapping(source = "timeActivityId", target = "id.timeActivityId")
    @Mapping(source = "subactivityId", target = "subactivity.subactivityId")
    @Mapping(source = "processActivityId", target = "processActivity.processActivityId")
    TimeActivity toEntity(TimeActivityDTO timeActivityDTO);

    List<TimeActivityDTO> toDTOList(List<TimeActivity> timeActivities);
    List<TimeActivity> toEntityList(List<TimeActivityDTO> timeActivityDTOs);
}
