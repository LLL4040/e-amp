package backend.Repository;

import backend.Entity.Jointo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface JointoRepository extends JpaRepository<Jointo, String> {
    List<Jointo> findAllByPerson(String person);
    List<Jointo> findAllByInvolve(Long involve);
    Boolean existsByPersonAndInvolve(String person, Long involve);
}
