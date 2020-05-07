package backend.Repository;

import backend.Entity.Friend;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FriendRepository extends JpaRepository<Friend, String> {
    Boolean existsByFriend1AndFriend2(String friend1, String friend2);
    List<Friend> findAllByFriend1(String friend1);
}
