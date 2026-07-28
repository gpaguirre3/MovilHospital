package hospital.practice.security;

import hospital.practice.model.Person;
import hospital.practice.repository.PersonRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

    private final PersonRepository personRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Person person = personRepository.findByPersonUsername(username)
                .or(() -> personRepository.findByPersonEmail(username))
                .orElseThrow(() -> new UsernameNotFoundException("User not found with username or email: " + username));
        return new CustomUserDetails(person);
    }
}
