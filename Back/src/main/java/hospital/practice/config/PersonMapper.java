package hospital.practice.config;

import hospital.practice.dto.PersonDTO;
import hospital.practice.model.Person;
import org.mapstruct.Mapper;
import java.util.List;

@Mapper(componentModel = "spring")
public interface PersonMapper {
    PersonDTO toDTO(Person person);
    Person toEntity(PersonDTO personDTO);
    List<PersonDTO> toDTOList(List<Person> persons);
    List<Person> toEntityList(List<PersonDTO> personDTOs);
}
