package hospital.practice.service;

import hospital.practice.dto.AuthResponseDTO;
import hospital.practice.dto.LoginRequestDTO;
import hospital.practice.dto.PersonDTO;

public interface AuthService {
    AuthResponseDTO login(LoginRequestDTO request);
    AuthResponseDTO register(PersonDTO personDTO);
}
