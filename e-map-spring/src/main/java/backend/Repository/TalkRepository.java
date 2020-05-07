package backend.Repository;

import backend.Entity.Talk;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TalkRepository extends JpaRepository<Talk, String> {
    List<Talk> findAllByTo(String to);
    List<Talk> findAllByFromAndTo(String from, String to);
    Boolean existsByToAndStatus(String to, Integer status);
    List<Talk> findAllByToAndStatus(String to, Integer status);
}
