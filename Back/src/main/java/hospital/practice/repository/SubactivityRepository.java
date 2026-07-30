package hospital.practice.repository;

import hospital.practice.model.Subactivity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SubactivityRepository extends JpaRepository<Subactivity, Integer> {
    List<Subactivity> findByActivity_ActivityId(Integer activityId);
}
