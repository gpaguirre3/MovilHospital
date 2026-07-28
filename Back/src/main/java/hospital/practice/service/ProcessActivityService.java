package hospital.practice.service;

import hospital.practice.dto.ProcessActivityDTO;
import java.util.List;
import java.util.Optional;

public interface ProcessActivityService {
    List<ProcessActivityDTO> findAll();
    Optional<ProcessActivityDTO> findById(Integer id);
    ProcessActivityDTO save(ProcessActivityDTO processActivityDTO);
    void deleteById(Integer id);
}
