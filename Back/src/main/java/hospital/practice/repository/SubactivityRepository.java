package hospital.practice.repository;

import hospital.practice.model.Subactivity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SubactivityRepository extends JpaRepository<Subactivity, Integer> {
}
