package hospital.practice.service;

import hospital.practice.dto.SubactivityDTO;
import java.util.List;
import java.util.Optional;

public interface SubactivityService {
    List<SubactivityDTO> findAll();
    Optional<SubactivityDTO> findById(Integer id);
    List<SubactivityDTO> findByActivityId(Integer activityId);
    SubactivityDTO save(SubactivityDTO subactivityDTO);
    void deleteById(Integer id);
}
