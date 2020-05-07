package backend.WebSocket.Message.Entity;

public class RoomJoinMessage extends Message{
    private String name;

    public RoomJoinMessage(String name) {
        this.name = name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    @Override
    public String toString() {
        return "RoomJoinMessage{" +
                "name='" + name + '\'' +
                '}';
    }
}
