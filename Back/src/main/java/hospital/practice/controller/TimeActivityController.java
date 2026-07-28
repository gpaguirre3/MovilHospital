package hospital.practice.controller;

import hospital.practice.dto.TimeActivityDTO;
import hospital.practice.model.TimeActivityId;
import hospital.practice.service.TimeActivityService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/time-activities")
@RequiredArgsConstructor
public class TimeActivityController {

    private final TimeActivityService timeActivityService;

    @GetMapping
    public ResponseEntity<List<TimeActivityDTO>> getAllTimeActivities() {
        return ResponseEntity.ok(timeActivityService.findAll());
    }

    @GetMapping("/{subactivityId}/{processActivityId}/{timeActivityId}")
    public ResponseEntity<TimeActivityDTO> getTimeActivityById(
            @PathVariable Integer subactivityId,
            @PathVariable Integer processActivityId,
            @PathVariable Integer timeActivityId) {
        TimeActivityId id = new TimeActivityId(subactivityId, processActivityId, timeActivityId);
        return timeActivityService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<TimeActivityDTO> createTimeActivity(@RequestBody TimeActivityDTO timeActivityDTO) {
        return ResponseEntity.status(HttpStatus.CREATED).body(timeActivityService.save(timeActivityDTO));
    }

    @DeleteMapping("/{subactivityId}/{processActivityId}/{timeActivityId}")
    public ResponseEntity<Void> deleteTimeActivity(
            @PathVariable Integer subactivityId,
            @PathVariable Integer processActivityId,
            @PathVariable Integer timeActivityId) {
        TimeActivityId id = new TimeActivityId(subactivityId, processActivityId, timeActivityId);
        return timeActivityService.findById(id)
                .map(existing -> {
                    timeActivityService.deleteById(id);
                    return ResponseEntity.noContent().<Void>build();
                })
                .orElse(ResponseEntity.notFound().build());
    }
}
