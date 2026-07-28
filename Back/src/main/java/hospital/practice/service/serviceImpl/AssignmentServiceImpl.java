package hospital.practice.service.serviceImpl;

import hospital.practice.config.AssignmentMapper;
import hospital.practice.dto.AssignmentDTO;
import hospital.practice.model.Assignment;
import hospital.practice.repository.AssignmentRepository;
import hospital.practice.service.AssignmentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AssignmentServiceImpl implements AssignmentService {

    private final AssignmentRepository assignmentRepository;
    private final AssignmentMapper assignmentMapper;

    @Override
    @Transactional(readOnly = true)
    public List<AssignmentDTO> findAll() {
        return assignmentMapper.toDTOList(assignmentRepository.findAll());
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<AssignmentDTO> findById(Integer id) {
        return assignmentRepository.findById(id).map(assignmentMapper::toDTO);
    }

    @Override
    @Transactional
    public AssignmentDTO save(AssignmentDTO assignmentDTO) {
        Assignment entity = assignmentMapper.toEntity(assignmentDTO);
        return assignmentMapper.toDTO(assignmentRepository.save(entity));
    }

    @Override
    @Transactional
    public void deleteById(Integer id) {
        assignmentRepository.deleteById(id);
    }
}
