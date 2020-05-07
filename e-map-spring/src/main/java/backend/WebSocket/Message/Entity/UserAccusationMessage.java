package backend.WebSocket.Message.Entity;

public class UserAccusationMessage extends Message{
    private String name;
    private Long id;
    private String content;

    public UserAccusationMessage(String name, Long id, String content) {
        this.name = name;
        this.id = id;
        this.content = content;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getContent() {
        return content;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
