package hospital.practice.service;

import hospital.practice.config.RecordMapper;
import hospital.practice.dto.RecordDTO;
import hospital.practice.model.Assignment;
import hospital.practice.model.Record;
import hospital.practice.repository.AssignmentRepository;
import hospital.practice.repository.RecordRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RecordServiceImpl implements RecordService {

    private final RecordRepository recordRepository;
    private final AssignmentRepository assignmentRepository;
    private final RecordMapper recordMapper;

    @Override
    public List<RecordDTO> findAll() {
        return recordRepository.findAll().stream()
                .map(recordMapper::toDTO)
                .collect(Collectors.toList());
    }

    @Override
    public Optional<RecordDTO> findById(Integer id) {
        return recordRepository.findById(id)
                .map(recordMapper::toDTO);
    }

    @Override
    public List<RecordDTO> findByAssignmentId(Integer assignmentId) {
        return recordRepository.findByAssignment_AssignmentsId(assignmentId).stream()
                .map(recordMapper::toDTO)
                .collect(Collectors.toList());
    }

    @Override
    public RecordDTO save(RecordDTO recordDTO) {
        Assignment assignment = null;
        if (recordDTO.getAssignmentsId() != null) {
            assignment = assignmentRepository.findById(recordDTO.getAssignmentsId()).orElse(null);
        }
        Record entity = recordMapper.toEntity(recordDTO, assignment);
        Record saved = recordRepository.save(entity);
        return recordMapper.toDTO(saved);
    }

    @Override
    public void deleteById(Integer id) {
        recordRepository.deleteById(id);
    }
}
