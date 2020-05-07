package backend.WebSocket.Message.Entity;

public class SystemMessage extends Message{
    private String user;
    private String content;
    private String time;

    public SystemMessage(String user, String content, String time) {
        this.user = user;
        this.content = content;
        this.time = time;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getContent() {
        return content;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    @Override
    public String toString() {
        return "SystemMessage{" +
                "user='" + user + '\'' +
                ", content='" + content + '\'' +
                ", time='" + time + '\'' +
                '}';
    }
}
