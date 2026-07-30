package hospital.practice.service;

import hospital.practice.dto.RecordDTO;
import java.util.List;
import java.util.Optional;

public interface RecordService {
    List<RecordDTO> findAll();
    Optional<RecordDTO> findById(Integer id);
    List<RecordDTO> findByAssignmentId(Integer assignmentId);
    RecordDTO save(RecordDTO recordDTO);
    void deleteById(Integer id);
}
