package hospital.practice.service;

import hospital.practice.dto.TimeActivityDTO;
import hospital.practice.model.TimeActivityId;
import java.util.List;
import java.util.Optional;

public interface TimeActivityService {
    List<TimeActivityDTO> findAll();
    Optional<TimeActivityDTO> findById(TimeActivityId id);
    TimeActivityDTO save(TimeActivityDTO timeActivityDTO);
    void deleteById(TimeActivityId id);
}
