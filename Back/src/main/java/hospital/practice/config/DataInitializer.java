package hospital.practice.config;

import hospital.practice.model.Activity;
import hospital.practice.model.Assignment;
import hospital.practice.model.Person;
import hospital.practice.model.Record;
import hospital.practice.model.Role;
import hospital.practice.model.Subactivity;
import hospital.practice.repository.ActivityRepository;
import hospital.practice.repository.AssignmentRepository;
import hospital.practice.repository.PersonRepository;
import hospital.practice.repository.RecordRepository;
import hospital.practice.repository.SubactivityRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {

    private final PersonRepository personRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) throws Exception {
        if (personRepository.count() == 0) {
            log.info("No users found in database. Initializing default ADMIN user...");
            Person admin = Person.builder()
                    .personUsername("admin")
                    .personPassword(passwordEncoder.encode("admin123"))
                    .personEmail("admin@hospital.com")
                    .personRole(Role.ADMIN)
                    .personName("Administrador")
                    .personLastname("Sistema")
                    .build();
            personRepository.save(admin);
            log.info("Default ADMIN user created successfully (username: admin / password: admin123)");
        }
    }
}
