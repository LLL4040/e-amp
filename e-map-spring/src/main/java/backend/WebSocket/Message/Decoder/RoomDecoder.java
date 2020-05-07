package backend.WebSocket.Message.Decoder;

import backend.WebSocket.Message.Entity.*;
import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;
import net.minidev.json.parser.ParseException;

import javax.websocket.DecodeException;
import javax.websocket.Decoder;
import javax.websocket.EndpointConfig;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class RoomDecoder implements Decoder.Text<Message> {
    private Map<String, String> messageMap;

    @Override
    public void init(EndpointConfig ec) { }

    @Override
    public void destroy() { }

    @Override
    public Message decode(String string) throws DecodeException {
        Message msg = null;
        if(willDecode(string)) {
            switch (messageMap.get("type")) {
                case "join":
                    msg = new RoomJoinMessage(messageMap.get("user"));
                    break;
                case "talk":
                    msg = new RoomChatMessage(messageMap.get("user"),
                            messageMap.get("content"));

            }
        } else {
            throw new DecodeException(string, "[Message] Can't decode.");
        }
        return msg;
    }

    @Override
    public boolean willDecode(String string) {
        boolean decodes = false;
        messageMap = new HashMap<>();
        JSONParser parser = new JSONParser();
        try {
            JSONObject object = (JSONObject) parser.parse(string);
            for(String key : object.keySet()) {
                messageMap.put(key, object.get(key).toString());
            }
            Set keys = messageMap.keySet();
            if(keys.contains("type")) {
                switch (messageMap.get("type")) {
                    case "join":
                        if (keys.contains("user"))
                            decodes = true;
                        break;
                    case "talk":
                        String[] msgKeys = {"user", "content"};
                        if (keys.containsAll(Arrays.asList(msgKeys))) {
                            decodes = true;
                        }
                        break;
                }
            }
            return decodes;
        } catch (ParseException e) {
            e.printStackTrace();
            return false;
        }
    }
}
