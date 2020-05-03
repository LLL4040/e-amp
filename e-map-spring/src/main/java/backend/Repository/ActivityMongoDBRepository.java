package backend.Repository;

import backend.Entity.Activity;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface ActivityMongoDBRepository extends MongoRepository<Activity, String> {
    List<Activity> findAllByEndBefore(String time);
}
