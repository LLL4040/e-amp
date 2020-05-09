package backend.WebSocket.Message.Encoder;

import backend.WebSocket.Message.Entity.RoomChatMessage;
import net.minidev.json.JSONObject;

import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

public class RoomChatMessageEncoder implements Encoder.Text<RoomChatMessage> {
    @Override
    public void init(EndpointConfig ec) { }

    @Override
    public void destroy() { }

    @Override
    public String encode(RoomChatMessage roomChatMessage) {
        JSONObject object = new JSONObject();
        object.put("type", "talk");
        object.put("user", roomChatMessage.getUser());
        object.put("content", roomChatMessage.getContent());
        return object.toJSONString();
    }
}
