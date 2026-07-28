package hospital.practice.controller;

import hospital.practice.dto.SubactivityDTO;
import hospital.practice.service.SubactivityService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/subactivities")
@RequiredArgsConstructor
public class SubactivityController {

    private final SubactivityService subactivityService;

    @GetMapping
    public ResponseEntity<List<SubactivityDTO>> getAllSubactivities() {
        return ResponseEntity.ok(subactivityService.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<SubactivityDTO> getSubactivityById(@PathVariable Integer id) {
        return subactivityService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<SubactivityDTO> createSubactivity(@RequestBody SubactivityDTO subactivityDTO) {
        return ResponseEntity.status(HttpStatus.CREATED).body(subactivityService.save(subactivityDTO));
    }

    @PutMapping("/{id}")
    public ResponseEntity<SubactivityDTO> updateSubactivity(@PathVariable Integer id, @RequestBody SubactivityDTO subactivityDTO) {
        return subactivityService.findById(id)
                .map(existing -> {
                    subactivityDTO.setSubactivityId(id);
                    return ResponseEntity.ok(subactivityService.save(subactivityDTO));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSubactivity(@PathVariable Integer id) {
        return subactivityService.findById(id)
                .map(existing -> {
                    subactivityService.deleteById(id);
                    return ResponseEntity.noContent().<Void>build();
                })
                .orElse(ResponseEntity.notFound().build());
    }
}
