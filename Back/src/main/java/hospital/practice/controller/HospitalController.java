package hospital.practice.controller;

import hospital.practice.dto.HospitalDTO;
import hospital.practice.service.HospitalService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/hospitals")
@RequiredArgsConstructor
public class HospitalController {

    private final HospitalService hospitalService;

    @GetMapping
    public ResponseEntity<List<HospitalDTO>> getAllHospitals() {
        return ResponseEntity.ok(hospitalService.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<HospitalDTO> getHospitalById(@PathVariable Integer id) {
        return hospitalService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<HospitalDTO> createHospital(@RequestBody HospitalDTO hospitalDTO) {
        return ResponseEntity.status(HttpStatus.CREATED).body(hospitalService.save(hospitalDTO));
    }

    @PutMapping("/{id}")
    public ResponseEntity<HospitalDTO> updateHospital(@PathVariable Integer id, @RequestBody HospitalDTO hospitalDTO) {
        return hospitalService.findById(id)
                .map(existing -> {
                    hospitalDTO.setHospitalId(id);
                    return ResponseEntity.ok(hospitalService.save(hospitalDTO));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteHospital(@PathVariable Integer id) {
        return hospitalService.findById(id)
                .map(existing -> {
                    hospitalService.deleteById(id);
                    return ResponseEntity.noContent().<Void>build();
                })
                .orElse(ResponseEntity.notFound().build());
    }
}
