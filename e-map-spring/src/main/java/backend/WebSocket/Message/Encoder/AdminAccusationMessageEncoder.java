package backend.WebSocket.Message.Encoder;


import backend.WebSocket.Message.Entity.AdminAccusationMessage;
import net.minidev.json.JSONObject;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

public class AdminAccusationMessageEncoder implements Encoder.Text<AdminAccusationMessage> {
    @Override
    public void init(EndpointConfig ec) { }

    @Override
    public void destroy() { }

    @Override
    public String encode(AdminAccusationMessage adminAccusationMessage) {
        JSONObject object = new JSONObject();
        object.put("type", "accusation");
        object.put("user", adminAccusationMessage.getName());
        object.put("id", adminAccusationMessage.getId());
        object.put("content", adminAccusationMessage.getContent());
        return object.toJSONString();
    }
}
