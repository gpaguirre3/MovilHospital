package hospital.practice.service;

import hospital.practice.dto.PersonDTO;
import java.util.List;
import java.util.Optional;

public interface PersonService {
    List<PersonDTO> findAll();
    Optional<PersonDTO> findById(Integer id);
    Optional<PersonDTO> findByUsername(String username);
    Optional<PersonDTO> findByEmail(String email);
    PersonDTO save(PersonDTO personDTO);
    void deleteById(Integer id);
}
