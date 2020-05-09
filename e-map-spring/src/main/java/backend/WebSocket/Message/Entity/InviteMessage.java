package backend.WebSocket.Message.Entity;

public class InviteMessage extends Message{
    private String from;
    private String to;
    private String time;
    private String message;

    public InviteMessage(String from, String to, String time, String message) {
        this.from = from;
        this.to = to;
        this.time = time;
        this.message = message;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getFrom() {
        return from;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getTo() {
        return to;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getTime() {
        return time;
    }

    @Override
    public String toString() {
        return "InviteMessage{" +
                "from='" + from + '\'' +
                ", to='" + to + '\'' +
                ", time='" + time + '\'' +
                ", message='" + message + '\'' +
                '}';
    }
}
