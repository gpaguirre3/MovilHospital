package hospital.practice.service.serviceImpl;

import hospital.practice.config.HospitalMapper;
import hospital.practice.dto.HospitalDTO;
import hospital.practice.model.Hospital;
import hospital.practice.repository.HospitalRepository;
import hospital.practice.service.HospitalService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class HospitalServiceImpl implements HospitalService {

    private final HospitalRepository hospitalRepository;
    private final HospitalMapper hospitalMapper;

    @Override
    @Transactional(readOnly = true)
    public List<HospitalDTO> findAll() {
        return hospitalMapper.toDTOList(hospitalRepository.findAll());
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<HospitalDTO> findById(Integer id) {
        return hospitalRepository.findById(id).map(hospitalMapper::toDTO);
    }

    @Override
    @Transactional
    public HospitalDTO save(HospitalDTO hospitalDTO) {
        Hospital entity = hospitalMapper.toEntity(hospitalDTO);
        return hospitalMapper.toDTO(hospitalRepository.save(entity));
    }

    @Override
    @Transactional
    public void deleteById(Integer id) {
        hospitalRepository.deleteById(id);
    }
}
