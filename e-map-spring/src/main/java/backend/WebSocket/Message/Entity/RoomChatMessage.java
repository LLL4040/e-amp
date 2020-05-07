package backend.WebSocket.Message.Entity;

public class RoomChatMessage extends Message{
    private String user;
    private String content;

    public RoomChatMessage(String user, String content) {
        this.user = user;
        this.content = content;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "RoomChatMessage{" +
                "user='" + user + '\'' +
                ", content='" + content + '\'' +
                '}';
    }
}
