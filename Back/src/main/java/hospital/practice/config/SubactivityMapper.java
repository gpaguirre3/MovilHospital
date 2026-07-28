package hospital.practice.config;

import hospital.practice.dto.SubactivityDTO;
import hospital.practice.model.Subactivity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import java.util.List;

@Mapper(componentModel = "spring", uses = {ActivityMapper.class})
public interface SubactivityMapper {

    @Mapping(source = "activity.activityId", target = "activityId")
    SubactivityDTO toDTO(Subactivity subactivity);

    @Mapping(source = "activityId", target = "activity.activityId")
    Subactivity toEntity(SubactivityDTO subactivityDTO);

    List<SubactivityDTO> toDTOList(List<Subactivity> subactivities);
    List<Subactivity> toEntityList(List<SubactivityDTO> subactivityDTOs);
}
