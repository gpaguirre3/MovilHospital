package hospital.practice.service;

import hospital.practice.dto.ActivityDTO;
import java.util.List;
import java.util.Optional;

public interface ActivityService {
    List<ActivityDTO> findAll();
    Optional<ActivityDTO> findById(Integer id);
    ActivityDTO save(ActivityDTO activityDTO);
    void deleteById(Integer id);
}
