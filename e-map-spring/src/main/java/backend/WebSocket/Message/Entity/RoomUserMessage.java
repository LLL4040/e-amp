package backend.WebSocket.Message.Entity;

import java.util.List;

public class RoomUserMessage extends Message{
    private List<String> userlist;

    public RoomUserMessage(List<String> userlist) {
        this.userlist = userlist;
    }

    public List<String> getUserlist() {
        return userlist;
    }

    public void setUserlist(List<String> userlist) {
        this.userlist = userlist;
    }

    @Override
    public String toString() {
        return "RoomUserMessage{" +
                "userlist=" + userlist.toString() +
                '}';
    }
}
