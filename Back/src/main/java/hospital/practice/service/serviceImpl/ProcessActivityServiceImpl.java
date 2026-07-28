package hospital.practice.service.serviceImpl;

import hospital.practice.config.ProcessActivityMapper;
import hospital.practice.dto.ProcessActivityDTO;
import hospital.practice.model.ProcessActivity;
import hospital.practice.repository.ProcessActivityRepository;
import hospital.practice.service.ProcessActivityService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProcessActivityServiceImpl implements ProcessActivityService {

    private final ProcessActivityRepository processActivityRepository;
    private final ProcessActivityMapper processActivityMapper;

    @Override
    @Transactional(readOnly = true)
    public List<ProcessActivityDTO> findAll() {
        return processActivityMapper.toDTOList(processActivityRepository.findAll());
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<ProcessActivityDTO> findById(Integer id) {
        return processActivityRepository.findById(id).map(processActivityMapper::toDTO);
    }

    @Override
    @Transactional
    public ProcessActivityDTO save(ProcessActivityDTO processActivityDTO) {
        ProcessActivity entity = processActivityMapper.toEntity(processActivityDTO);
        return processActivityMapper.toDTO(processActivityRepository.save(entity));
    }

    @Override
    @Transactional
    public void deleteById(Integer id) {
        processActivityRepository.deleteById(id);
    }
}
