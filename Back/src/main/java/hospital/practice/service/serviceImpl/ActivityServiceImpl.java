package hospital.practice.service.serviceImpl;

import hospital.practice.config.ActivityMapper;
import hospital.practice.dto.ActivityDTO;
import hospital.practice.model.Activity;
import hospital.practice.repository.ActivityRepository;
import hospital.practice.service.ActivityService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ActivityServiceImpl implements ActivityService {

    private final ActivityRepository activityRepository;
    private final ActivityMapper activityMapper;

    @Override
    @Transactional(readOnly = true)
    public List<ActivityDTO> findAll() {
        return activityMapper.toDTOList(activityRepository.findAll());
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<ActivityDTO> findById(Integer id) {
        return activityRepository.findById(id).map(activityMapper::toDTO);
    }

    @Override
    @Transactional(readOnly = true)
    public List<ActivityDTO> findByRecordId(Integer recordId) {
        return activityMapper.toDTOList(activityRepository.findByRecord_RecordId(recordId));
    }

    @Override
    @Transactional
    public ActivityDTO save(ActivityDTO activityDTO) {
        Activity entity = activityMapper.toEntity(activityDTO);
        return activityMapper.toDTO(activityRepository.save(entity));
    }

    @Override
    @Transactional
    public void deleteById(Integer id) {
        activityRepository.deleteById(id);
    }
}
