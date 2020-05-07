package backend.WebSocket.Message.Encoder;

import backend.WebSocket.Message.Entity.ChatMessage;
import backend.WebSocket.Message.Entity.RoomUserMessage;
import net.minidev.json.JSONObject;

import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

public class TalkMessageEncoder implements Encoder.Text<ChatMessage>{
    @Override
    public void init(EndpointConfig ec) { }

    @Override
    public void destroy() { }

    @Override
    public String encode(ChatMessage chatMessage) {
        JSONObject object = new JSONObject();
        object.put("type", "talk");
        object.put("from", chatMessage.getFrom());
        object.put("to", chatMessage.getTo());
        object.put("time", chatMessage.getTime());
        object.put("message", chatMessage.getMessage());
        return object.toJSONString();
    }
}
