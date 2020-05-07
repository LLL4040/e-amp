package backend.Entity;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "talk")
public class Talk {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "sender")
    private String from;

    @Column(name = "receiver")
    private String to;

    @Column(name = "time")
    private String when;

    @Column(name = "content")
    private String content;

    @Column(name = "status")
    private Integer status;

    public Talk() {}

    public Talk(String from, String to, String when, String content, Integer status) {
        this.from = from;
        this.to = to;
        this.when = when;
        this.content = content;
        this.status = status;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getFrom() {
        return from;
    }

    public String getTo() {
        return to;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getWhen() {
        return when;
    }

    public void setWhen(String when) {
        this.when = when;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Talk talk = (Talk) o;
        return id.equals(talk.id) &&
                from.equals(talk.from) &&
                to.equals(talk.to) &&
                when.equals(talk.when) &&
                content.equals(talk.content) &&
                status.equals(talk.status);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, from, to, when, content, status);
    }
}
