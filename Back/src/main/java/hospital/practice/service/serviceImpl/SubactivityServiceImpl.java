package hospital.practice.service.serviceImpl;

import hospital.practice.config.SubactivityMapper;
import hospital.practice.dto.SubactivityDTO;
import hospital.practice.model.Subactivity;
import hospital.practice.repository.SubactivityRepository;
import hospital.practice.service.SubactivityService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class SubactivityServiceImpl implements SubactivityService {

    private final SubactivityRepository subactivityRepository;
    private final SubactivityMapper subactivityMapper;

    @Override
    @Transactional(readOnly = true)
    public List<SubactivityDTO> findAll() {
        return subactivityMapper.toDTOList(subactivityRepository.findAll());
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<SubactivityDTO> findById(Integer id) {
        return subactivityRepository.findById(id).map(subactivityMapper::toDTO);
    }

    @Override
    @Transactional(readOnly = true)
    public List<SubactivityDTO> findByActivityId(Integer activityId) {
        return subactivityMapper.toDTOList(subactivityRepository.findByActivity_ActivityId(activityId));
    }

    @Override
    @Transactional
    public SubactivityDTO save(SubactivityDTO subactivityDTO) {
        Subactivity entity = subactivityMapper.toEntity(subactivityDTO);
        return subactivityMapper.toDTO(subactivityRepository.save(entity));
    }

    @Override
    @Transactional
    public void deleteById(Integer id) {
        subactivityRepository.deleteById(id);
    }
}
