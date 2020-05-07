package backend.WebSocket.Message.Entity;

public class AdminJoinMessage extends Message{
    private String name;

    public AdminJoinMessage(String name) {
        this.name = name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
