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

public class ChatDecoder implements Decoder.Text<Message> {
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
                    msg = new JoinMessage(messageMap.get("user"));
                    break;
                case "talk":
                    msg = new ChatMessage(messageMap.get("from"),
                            messageMap.get("to"),
                            messageMap.get("time"),
                            messageMap.get("message"));
                case "invite":
                    msg = new InviteMessage(messageMap.get("from"),
                            messageMap.get("to"),
                            messageMap.get("time"),
                            messageMap.get("message"));
                    break;
                case "system":
                    msg = new SystemMessage(messageMap.get("to"),
                            messageMap.get("message"),
                            messageMap.get("time"));

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
                        String[] msgKeys1 = {"from", "time", "to", "message"};
                        if (keys.containsAll(Arrays.asList(msgKeys1))) {
                            decodes = true;
                        }
                        break;
                    case "system":
                        String[] msgKeys2 = {"to", "time", "message"};
                        if (keys.containsAll(Arrays.asList(msgKeys2))) {
                            decodes = true;
                        }
                        break;
                    case "invite":
                        String[] msgKeys3 = {"from", "time", "to", "message"};
                        if (keys.containsAll(Arrays.asList(msgKeys3))) {
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
