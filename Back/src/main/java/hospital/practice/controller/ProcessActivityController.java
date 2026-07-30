package hospital.practice.controller;

import hospital.practice.dto.ProcessActivityDTO;
import hospital.practice.service.ProcessActivityService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/process-activities")
@RequiredArgsConstructor
public class ProcessActivityController {

    private final ProcessActivityService processActivityService;

    @GetMapping
    public ResponseEntity<List<ProcessActivityDTO>> getAllProcessActivities() {
        return ResponseEntity.ok(processActivityService.findAll());
    }

    @GetMapping("/events")
    public ResponseEntity<hospital.practice.model.ProcessActivityEvent[]> getProcessActivityEvents() {
        return ResponseEntity.ok(hospital.practice.model.ProcessActivityEvent.values());
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProcessActivityDTO> getProcessActivityById(@PathVariable Integer id) {
        return processActivityService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<ProcessActivityDTO> createProcessActivity(@RequestBody ProcessActivityDTO processActivityDTO) {
        return ResponseEntity.status(HttpStatus.CREATED).body(processActivityService.save(processActivityDTO));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ProcessActivityDTO> updateProcessActivity(@PathVariable Integer id, @RequestBody ProcessActivityDTO processActivityDTO) {
        return processActivityService.findById(id)
                .map(existing -> {
                    processActivityDTO.setProcessActivityId(id);
                    if (processActivityDTO.getProcessActivityDateStart() == null) {
                        processActivityDTO.setProcessActivityDateStart(existing.getProcessActivityDateStart());
                    }
                    if (processActivityDTO.getPersonId() == null) {
                        processActivityDTO.setPersonId(existing.getPersonId());
                    }
                    if (processActivityDTO.getHospitalId() == null) {
                        processActivityDTO.setHospitalId(existing.getHospitalId());
                    }
                    return ResponseEntity.ok(processActivityService.save(processActivityDTO));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProcessActivity(@PathVariable Integer id) {
        return processActivityService.findById(id)
                .map(existing -> {
                    processActivityService.deleteById(id);
                    return ResponseEntity.noContent().<Void>build();
                })
                .orElse(ResponseEntity.notFound().build());
    }
}
