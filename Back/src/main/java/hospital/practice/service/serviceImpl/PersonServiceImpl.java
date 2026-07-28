package hospital.practice.service.serviceImpl;

import hospital.practice.config.PersonMapper;
import hospital.practice.dto.PersonDTO;
import hospital.practice.model.Person;
import hospital.practice.repository.PersonRepository;
import hospital.practice.service.PersonService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class PersonServiceImpl implements PersonService {

    private final PersonRepository personRepository;
    private final PersonMapper personMapper;
    private final PasswordEncoder passwordEncoder;

    @Override
    @Transactional(readOnly = true)
    public List<PersonDTO> findAll() {
        return personMapper.toDTOList(personRepository.findAll());
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<PersonDTO> findById(Integer id) {
        return personRepository.findById(id).map(personMapper::toDTO);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<PersonDTO> findByUsername(String username) {
        return personRepository.findByPersonUsername(username).map(personMapper::toDTO);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<PersonDTO> findByEmail(String email) {
        return personRepository.findByPersonEmail(email).map(personMapper::toDTO);
    }

    @Override
    @Transactional
    public PersonDTO save(PersonDTO personDTO) {
        Person entity = personMapper.toEntity(personDTO);
        if (entity.getPersonPassword() != null && !entity.getPersonPassword().startsWith("$2a$")) {
            entity.setPersonPassword(passwordEncoder.encode(entity.getPersonPassword()));
        }
        return personMapper.toDTO(personRepository.save(entity));
    }

    @Override
    @Transactional
    public void deleteById(Integer id) {
        personRepository.deleteById(id);
    }
}
