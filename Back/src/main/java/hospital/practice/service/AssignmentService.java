package hospital.practice.service;

import hospital.practice.dto.AssignmentDTO;
import java.util.List;
import java.util.Optional;

public interface AssignmentService {
    List<AssignmentDTO> findAll();
    Optional<AssignmentDTO> findById(Integer id);
    AssignmentDTO save(AssignmentDTO assignmentDTO);
    void deleteById(Integer id);
}
