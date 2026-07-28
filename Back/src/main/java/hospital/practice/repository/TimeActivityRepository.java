package hospital.practice.repository;

import hospital.practice.model.TimeActivity;
import hospital.practice.model.TimeActivityId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TimeActivityRepository extends JpaRepository<TimeActivity, TimeActivityId> {
}
