package backend.WebSocket.Message.Encoder;

import backend.WebSocket.Message.Entity.RoomUserMessage;
import backend.WebSocket.Message.Entity.SystemMessage;
import net.minidev.json.JSONObject;

import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

public class SystemMessageEncoder implements Encoder.Text<SystemMessage>{
    @Override
    public void init(EndpointConfig ec) { }

    @Override
    public void destroy() { }

    @Override
    public String encode(SystemMessage systemMessage) {
        JSONObject object = new JSONObject();
        object.put("type", "system");
        object.put("to", systemMessage.getUser());
        object.put("time", systemMessage.getTime());
        object.put("message", systemMessage.getContent());
        return object.toJSONString();
    }
}
