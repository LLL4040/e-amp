package backend.WebSocket;

import backend.WebSocket.Message.Decoder.MessageDecoder;
import backend.WebSocket.Message.Decoder.RoomDecoder;
import backend.WebSocket.Message.Encoder.AdminAccusationMessageEncoder;
import backend.WebSocket.Message.Encoder.RoomChatMessageEncoder;
import backend.WebSocket.Message.Encoder.RoomUserMessageEncoder;
import backend.WebSocket.Message.Entity.*;
import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

@Component
@ServerEndpoint(
        value = "/websocket/api/room/{activityId}",
        decoders = {
                RoomDecoder.class
        },
        encoders = {
                RoomChatMessageEncoder.class,
                RoomUserMessageEncoder.class
        }
)
public class RoomServer {
    private static Logger logger = Logger.getLogger("websocket");
    private static final Map<String, Set<Session>> rooms = new ConcurrentHashMap();
    private static final Map<String, List<String>> roomUsers = new ConcurrentHashMap<>();

    @OnOpen
    public void connect(@PathParam("activityId") String roomName, Session session) throws Exception {
        // 将session按照房间名来存储，将各个房间的用户隔离
        if (!rooms.containsKey(roomName)) {
            // 创建房间不存在时，创建房间
            Set<Session> room = new HashSet<>();
            // 添加用户
            room.add(session);
            rooms.put(roomName, room);
            List<String> users = new ArrayList<>();
            roomUsers.put(roomName, users);
        } else {
            // 房间已存在，直接添加用户到相应的房间
            rooms.get(roomName).add(session);
        }
        logger.log(Level.INFO, "Connection opened.");
    }

    @OnClose
    public void disConnect(@PathParam("activityId") String roomName, Session session) {
        rooms.get(roomName).remove(session);
        logger.log(Level.INFO, "Connection closed.");
    }

    @OnMessage
    public void receiveMsg(@PathParam("activityId") String roomName,
                           Message msg, Session session) throws Exception {
        if(msg instanceof RoomJoinMessage) {
            /* add the new user */
            RoomJoinMessage rjmsg = (RoomJoinMessage) msg;
            if(!roomUsers.get(roomName).contains(rjmsg.getName())) {
                roomUsers.get(roomName).add(rjmsg.getName());
            }
            RoomUserMessage rumsg = new RoomUserMessage(roomUsers.get(roomName));
            broadcast(roomName, rumsg);
            logger.log(Level.INFO, "Received: {0}", rjmsg.toString());
        } else if (msg instanceof RoomChatMessage) {
            /* forward the accusation to everybody */
            RoomChatMessage rcmsg = (RoomChatMessage) msg;
            broadcast(roomName, rcmsg);
            logger.log(Level.INFO, "Received: {0}", rcmsg.toString());
        }
    }

    @OnError
    public void error(Session session, Throwable t) {
        logger.log(Level.INFO, "Connection error ({0})", t.toString());
    }

    // 按照房间名进行广播
    public static void broadcast(String roomName, Object msg) throws Exception {
        for (Session session : rooms.get(roomName)) {
            session.getBasicRemote().sendObject(msg);
        }
    }

    public void endActivity(String roomName) throws Exception {
        String text = "{\"type\":\"end\"}";
        for (Session session : rooms.get(roomName)) {
            session.getBasicRemote().sendText(text);
        }
    }

}
