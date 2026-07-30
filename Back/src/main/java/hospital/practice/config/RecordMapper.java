package hospital.practice.config;

import hospital.practice.dto.RecordDTO;
import hospital.practice.model.Assignment;
import hospital.practice.model.Record;
import org.springframework.stereotype.Component;

@Component
public class RecordMapper {

    public RecordDTO toDTO(Record record) {
        if (record == null) return null;
        return RecordDTO.builder()
                .recordId(record.getRecordId())
                .recordName(record.getRecordName())
                .recordDescription(record.getRecordDescription())
                .assignmentsId(record.getAssignment() != null ? record.getAssignment().getAssignmentsId() : null)
                .build();
    }

    public Record toEntity(RecordDTO dto, Assignment assignment) {
        if (dto == null) return null;
        return Record.builder()
                .recordId(dto.getRecordId())
                .recordName(dto.getRecordName())
                .recordDescription(dto.getRecordDescription())
                .assignment(assignment)
                .build();
    }
}
