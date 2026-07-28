package hospital.practice.repository;

import hospital.practice.model.Person;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface PersonRepository extends JpaRepository<Person, Integer> {
    Optional<Person> findByPersonUsername(String username);
    Optional<Person> findByPersonEmail(String email);
}
