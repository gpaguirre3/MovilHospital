package hospital.practice.service;

import hospital.practice.dto.HospitalDTO;
import java.util.List;
import java.util.Optional;

public interface HospitalService {
    List<HospitalDTO> findAll();
    Optional<HospitalDTO> findById(Integer id);
    HospitalDTO save(HospitalDTO hospitalDTO);
    void deleteById(Integer id);
}
