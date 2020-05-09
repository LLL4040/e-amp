package backend.Entity;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "friend")
public class Friend {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "friend1")
    private String friend1;

    @Column(name = "friend2")
    private String friend2;

    public Friend() {}

    public Friend(String friend1, String friend2) {
        this.friend1 = friend1;
        this.friend2 = friend2;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFriend1() {
        return friend1;
    }

    public void setFriend1(String friend1) {
        this.friend1 = friend1;
    }

    public String getFriend2() {
        return friend2;
    }

    public void setFriend2(String friend2) {
        this.friend2 = friend2;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Friend friend = (Friend) o;
        return id.equals(friend.id) &&
                friend1.equals(friend.friend1) &&
                friend2.equals(friend.friend2);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, friend1, friend2);
    }
}
