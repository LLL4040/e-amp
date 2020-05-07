package backend.WebSocket.Message.Encoder;

import backend.WebSocket.Message.Entity.InviteMessage;
import net.minidev.json.JSONObject;

import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

public class InviteMessageEncoder implements Encoder.Text<InviteMessage>{
    @Override
    public void init(EndpointConfig ec) { }

    @Override
    public void destroy() { }

    @Override
    public String encode(InviteMessage inviteMessage) {
        JSONObject object = new JSONObject();
        object.put("type", "talk");
        object.put("from", inviteMessage.getFrom());
        object.put("to", inviteMessage.getTo());
        object.put("time", inviteMessage.getTime());
        object.put("message", inviteMessage.getMessage());
        return object.toJSONString();
    }
}
