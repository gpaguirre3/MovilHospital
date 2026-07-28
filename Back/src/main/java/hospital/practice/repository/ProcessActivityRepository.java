package hospital.practice.repository;

import hospital.practice.model.ProcessActivity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProcessActivityRepository extends JpaRepository<ProcessActivity, Integer> {
}
