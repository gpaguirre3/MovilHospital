package hospital.practice.repository;

import hospital.practice.model.Record;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecordRepository extends JpaRepository<Record, Integer> {
    List<Record> findByAssignment_AssignmentsId(Integer assignmentsId);
}
