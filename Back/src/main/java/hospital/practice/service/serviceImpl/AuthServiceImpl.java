package hospital.practice.service.serviceImpl;

import hospital.practice.config.PersonMapper;
import hospital.practice.dto.AuthResponseDTO;
import hospital.practice.dto.LoginRequestDTO;
import hospital.practice.dto.PersonDTO;
import hospital.practice.model.Person;
import hospital.practice.model.Role;
import hospital.practice.repository.PersonRepository;
import hospital.practice.security.CustomUserDetails;
import hospital.practice.security.JwtService;
import hospital.practice.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    private final PersonRepository personRepository;
    private final PersonMapper personMapper;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;

    @Override
    @Transactional(readOnly = true)
    public AuthResponseDTO login(LoginRequestDTO request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.getUsername(), request.getPassword())
        );
        Person person = personRepository.findByPersonUsername(request.getUsername())
                .or(() -> personRepository.findByPersonEmail(request.getUsername()))
                .orElseThrow(() -> new IllegalArgumentException("Invalid username or password"));

        CustomUserDetails userDetails = new CustomUserDetails(person);
        String jwtToken = jwtService.generateToken(userDetails);

        return AuthResponseDTO.builder()
                .token(jwtToken)
                .username(person.getPersonUsername())
                .role(person.getPersonRole() != null ? person.getPersonRole().name() : "USER")
                .personId(person.getPersonId())
                .message("Login successful")
                .build();
    }

    @Override
    @Transactional
    public AuthResponseDTO register(PersonDTO personDTO) {
        if (personRepository.findByPersonUsername(personDTO.getPersonUsername()).isPresent()) {
            throw new IllegalArgumentException("Username already exists: " + personDTO.getPersonUsername());
        }
        if (personDTO.getPersonEmail() != null && personRepository.findByPersonEmail(personDTO.getPersonEmail()).isPresent()) {
            throw new IllegalArgumentException("Email already exists: " + personDTO.getPersonEmail());
        }

        Person person = personMapper.toEntity(personDTO);
        person.setPersonPassword(passwordEncoder.encode(personDTO.getPersonPassword()));
        if (person.getPersonRole() == null) {
            person.setPersonRole(Role.USER);
        }
        Person savedPerson = personRepository.save(person);

        CustomUserDetails userDetails = new CustomUserDetails(savedPerson);
        String jwtToken = jwtService.generateToken(userDetails);

        return AuthResponseDTO.builder()
                .token(jwtToken)
                .username(savedPerson.getPersonUsername())
                .role(savedPerson.getPersonRole() != null ? savedPerson.getPersonRole().name() : "USER")
                .personId(savedPerson.getPersonId())
                .message("User registered successfully")
                .build();
    }
}
