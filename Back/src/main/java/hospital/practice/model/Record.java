package hospital.practice.model;

import jakarta.persistence.*;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "RECORD")
public class Record {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "RECORDID")
    private Integer recordId;

    @Column(name = "RECORDNAME", length = 128, nullable = false)
    private String recordName;

    @Column(name = "RECORDDESCRIPTION", length = 256)
    private String recordDescription;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ASSIGNMENTSID", nullable = false)
    private Assignment assignment;
}
