package backend.Entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.lang.model.util.AbstractAnnotationValueVisitor6;
import java.io.Serializable;
import java.util.Objects;

@Document(collection = "activity")
public class Activity implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    private String id;
    private String sponsor;
    private String name;
    private String tags;
    private Integer status;
    private String start;
    private String end;
    private Integer num;
    private Integer joined;
    private String location;
    private String description;

    public Activity() {}

    public Activity(String sponsor, String name, String tags, Integer status, String start, String end,
                    Integer num, Integer joined, String location, String description) {
        this.sponsor = sponsor;
        this.name = name;
        this.tags = tags;
        this.status = status;
        this.start = start;
        this.end = end;
        this.num = num;
        this.joined = joined;
        this.location = location;
        this.description = description;
    }

    public Integer getJoined() {
        return joined;
    }

    public Integer getNum() {
        return num;
    }

    public Integer getStatus() {
        return status;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getDescription() {
        return description;
    }

    public String getEnd() {
        return end;
    }

    public String getId() {
        return id;
    }

    public String getLocation() {
        return location;
    }

    public String getName() {
        return name;
    }

    public String getSponsor() {
        return sponsor;
    }

    public String getStart() {
        return start;
    }

    public String getTags() {
        return tags;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setJoined(Integer joined) {
        this.joined = joined;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public void setSponsor(String sponsor) {
        this.sponsor = sponsor;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    @Override
    public String toString() {
        return "Activity{" +
                "id='" + id + '\'' +
                ", sponsor='" + sponsor + '\'' +
                ", name='" + name + '\'' +
                ", tags='" + tags + '\'' +
                ", status=" + status +
                ", start='" + start + '\'' +
                ", end='" + end + '\'' +
                ", num=" + num +
                ", joined=" + joined +
                ", location='" + location + '\'' +
                ", description='" + description + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Activity activity = (Activity) o;
        return Objects.equals(id, activity.id) &&
                Objects.equals(sponsor, activity.sponsor) &&
                Objects.equals(name, activity.name) &&
                Objects.equals(tags, activity.tags) &&
                Objects.equals(status, activity.status) &&
                Objects.equals(start, activity.start) &&
                Objects.equals(end, activity.end) &&
                Objects.equals(num, activity.num) &&
                Objects.equals(joined, activity.joined) &&
                Objects.equals(location, activity.location) &&
                Objects.equals(description, activity.description);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, sponsor, name, tags, status, start, end, num, joined, location, description);
    }
}
