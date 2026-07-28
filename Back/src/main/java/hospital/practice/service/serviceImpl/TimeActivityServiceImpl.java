package hospital.practice.service.serviceImpl;

import hospital.practice.config.TimeActivityMapper;
import hospital.practice.dto.TimeActivityDTO;
import hospital.practice.model.TimeActivity;
import hospital.practice.model.TimeActivityId;
import hospital.practice.repository.TimeActivityRepository;
import hospital.practice.service.TimeActivityService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class TimeActivityServiceImpl implements TimeActivityService {

    private final TimeActivityRepository timeActivityRepository;
    private final TimeActivityMapper timeActivityMapper;

    @Override
    @Transactional(readOnly = true)
    public List<TimeActivityDTO> findAll() {
        return timeActivityMapper.toDTOList(timeActivityRepository.findAll());
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<TimeActivityDTO> findById(TimeActivityId id) {
        return timeActivityRepository.findById(id).map(timeActivityMapper::toDTO);
    }

    @Override
    @Transactional
    public TimeActivityDTO save(TimeActivityDTO timeActivityDTO) {
        TimeActivity entity = timeActivityMapper.toEntity(timeActivityDTO);
        return timeActivityMapper.toDTO(timeActivityRepository.save(entity));
    }

    @Override
    @Transactional
    public void deleteById(TimeActivityId id) {
        timeActivityRepository.deleteById(id);
    }
}
