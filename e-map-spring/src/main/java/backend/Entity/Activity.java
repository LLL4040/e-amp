package backend.Entity;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "activity")
public class Activity {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "sponsor")
    private String sponsor;

    @Column(name = "tags")
    private String tags;

    @Column(name = "status")
    private Integer status;

    @Column(name = "start")
    private String start;

    @Column(name = "end")
    private String end;

    @Column(name = "num")
    private Long num;

    @Column(name = "joined")
    private Long joined;

    @Column(name = "location")
    private String location;

    @Column(name = "description")
    private String description;

    public Activity() {}

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public String getTags() {
        return tags;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getStart() {
        return start;
    }

    public void setSponsor(String sponsor) {
        this.sponsor = sponsor;
    }

    public String getSponsor() {
        return sponsor;
    }

    public void setNum(Long num) {
        this.num = num;
    }

    public Long getNum() {
        return num;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getLocation() {
        return location;
    }

    public void setJoined(Long joined) {
        this.joined = joined;
    }

    public Long getJoined() {
        return joined;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    public String getEnd() {
        return end;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Activity activity = (Activity) o;
        return id.equals(activity.id) &&
                name.equals(activity.name) &&
                sponsor.equals(activity.sponsor) &&
                tags.equals(activity.tags) &&
                status.equals(activity.status) &&
                start.equals(activity.start) &&
                end.equals(activity.end) &&
                num.equals(activity.num) &&
                joined.equals(activity.joined);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, sponsor, tags, status, start, end, num, joined);
    }
}
