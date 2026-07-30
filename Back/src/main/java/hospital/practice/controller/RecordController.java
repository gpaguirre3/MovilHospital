package hospital.practice.controller;

import hospital.practice.dto.RecordDTO;
import hospital.practice.service.RecordService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/records")
@RequiredArgsConstructor
public class RecordController {

    private final RecordService recordService;

    @GetMapping
    public ResponseEntity<List<RecordDTO>> getAllRecords(
            @RequestParam(required = false) Integer assignmentId) {
        if (assignmentId != null) {
            return ResponseEntity.ok(recordService.findByAssignmentId(assignmentId));
        }
        return ResponseEntity.ok(recordService.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<RecordDTO> getRecordById(@PathVariable Integer id) {
        return recordService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<RecordDTO> createRecord(@RequestBody RecordDTO recordDTO) {
        return ResponseEntity.status(HttpStatus.CREATED).body(recordService.save(recordDTO));
    }

    @PutMapping("/{id}")
    public ResponseEntity<RecordDTO> updateRecord(@PathVariable Integer id, @RequestBody RecordDTO recordDTO) {
        return recordService.findById(id)
                .map(existing -> {
                    recordDTO.setRecordId(id);
                    return ResponseEntity.ok(recordService.save(recordDTO));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteRecord(@PathVariable Integer id) {
        return recordService.findById(id)
                .map(existing -> {
                    recordService.deleteById(id);
                    return ResponseEntity.noContent().<Void>build();
                })
                .orElse(ResponseEntity.notFound().build());
    }
}
