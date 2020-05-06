package backend.Repository;

import backend.Entity.Activity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ActivityRepository extends JpaRepository<Activity, String> {
    List<Activity> findAllByStartAfter(String start);
    Activity findById(Long id);
    List<Activity> findAllByStatusIsNot(Integer status);
    Boolean existsById(Long id);
}
