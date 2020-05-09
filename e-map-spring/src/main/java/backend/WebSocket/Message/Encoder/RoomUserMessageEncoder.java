package backend.WebSocket.Message.Encoder;

import backend.WebSocket.Message.Entity.RoomChatMessage;
import backend.WebSocket.Message.Entity.RoomUserMessage;
import net.minidev.json.JSONObject;

import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

public class RoomUserMessageEncoder implements Encoder.Text<RoomUserMessage>{
    @Override
    public void init(EndpointConfig ec) { }

    @Override
    public void destroy() { }

    @Override
    public String encode(RoomUserMessage roomUserMessage) {
        JSONObject object = new JSONObject();
        object.put("type", "users");
        object.put("users", roomUserMessage.getUserlist());
        return object.toJSONString();
    }
}
