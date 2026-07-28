package hospital.practice.config;

import hospital.practice.dto.ProcessActivityDTO;
import hospital.practice.model.ProcessActivity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import java.util.List;

@Mapper(componentModel = "spring", uses = {PersonMapper.class, HospitalMapper.class})
public interface ProcessActivityMapper {

    @Mapping(source = "person.personId", target = "personId")
    @Mapping(source = "hospital.hospitalId", target = "hospitalId")
    ProcessActivityDTO toDTO(ProcessActivity processActivity);

    @Mapping(source = "personId", target = "person.personId")
    @Mapping(source = "hospitalId", target = "hospital.hospitalId")
    ProcessActivity toEntity(ProcessActivityDTO processActivityDTO);

    List<ProcessActivityDTO> toDTOList(List<ProcessActivity> processActivities);
    List<ProcessActivity> toEntityList(List<ProcessActivityDTO> processActivityDTOs);
}
