package backend.Entity;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "jointo")
public class Jointo {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "person")
    private String person;

    @Column(name = "involve")
    private Long involve;

    public Jointo() {}

    public Jointo(String person, Long involve) {
        this.person = person;
        this.involve = involve;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getInvolve() {
        return involve;
    }

    public void setInvolve(Long involve) {
        this.involve = involve;
    }

    public String getPerson() {
        return person;
    }

    public void setPerson(String person) {
        this.person = person;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Jointo jointo = (Jointo) o;
        return id.equals(jointo.id) &&
                person.equals(jointo.person) &&
                involve.equals(jointo.involve);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, person, involve);
    }
}
