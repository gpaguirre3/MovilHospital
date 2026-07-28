package hospital.practice.config;

import hospital.practice.dto.HospitalDTO;
import hospital.practice.model.Hospital;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import java.util.List;

@Mapper(componentModel = "spring", uses = {AssignmentMapper.class, PersonMapper.class})
public interface HospitalMapper {

    @Mapping(source = "assignment.assignmentsId", target = "assignmentsId")
    @Mapping(source = "person.personId", target = "personId")
    HospitalDTO toDTO(Hospital hospital);

    @Mapping(source = "assignmentsId", target = "assignment.assignmentsId")
    @Mapping(source = "personId", target = "person.personId")
    Hospital toEntity(HospitalDTO hospitalDTO);

    List<HospitalDTO> toDTOList(List<Hospital> hospitals);
    List<Hospital> toEntityList(List<HospitalDTO> hospitalDTOs);
}
