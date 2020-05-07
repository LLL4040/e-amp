package backend.Repository;

import backend.Entity.Admin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AdminRepository extends JpaRepository<Admin, String> {
    Boolean existsByName(String name);
    Admin findByName(String name);
}
