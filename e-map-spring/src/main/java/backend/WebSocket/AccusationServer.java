package backend.WebSocket;

import backend.WebSocket.Message.Decoder.MessageDecoder;
import backend.WebSocket.Message.Encoder.AdminAccusationMessageEncoder;
import backend.WebSocket.Message.Entity.AdminAccusationMessage;
import backend.WebSocket.Message.Entity.AdminJoinMessage;
import backend.WebSocket.Message.Entity.Message;
import backend.WebSocket.Message.Entity.UserAccusationMessage;
import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

@Component
@ServerEndpoint(
        value = "/websocket/api/accusation",
        decoders = {
                MessageDecoder.class
        },
        encoders = {
                AdminAccusationMessageEncoder.class
        }
)
public class AccusationServer {
    private static Logger logger = Logger.getLogger("websocket");
    private static final List<Session> admins = new CopyOnWriteArrayList<>();


    @OnOpen
    public void openConnection(Session session) {
        logger.log(Level.INFO, "Connection opened.");
    }

    @OnMessage
    public void message(final Session session, Message msg) {
        logger.log(Level.INFO, "Received: {0}", msg.toString());

        if(msg instanceof AdminJoinMessage) {
            /* add the new admin */
            AdminJoinMessage amsg = (AdminJoinMessage) msg;
            session.getUserProperties().put("name", amsg.getName());
            session.getUserProperties().put("active", true);
            admins.add(session);
            logger.log(Level.INFO, "Received: {0}", amsg.toString());
        } else if (msg instanceof UserAccusationMessage) {
            /* forward the accusation to everybody */
            UserAccusationMessage umsg = (UserAccusationMessage) msg;
            logger.log(Level.INFO, "Received: {0}", umsg.toString());
            sendAll(session, new AdminAccusationMessage(umsg.getName(), umsg.getId(), umsg.getContent()));
        }
    }

    @OnClose
    public void closedConnection(Session session) {
        /* Notify everybody */
        session.getUserProperties().put("active", false);
        admins.remove(session);
        logger.log(Level.INFO, "Connection closed.");
    }

    @OnError
    public void error(Session session, Throwable t) {
        logger.log(Level.INFO, "Connection error ({0})", t.toString());
    }

    public void sendMessage(AdminAccusationMessage adminAccusationMessage) throws IOException, EncodeException {
        for(Session session : admins) {
            if(session.isOpen()) {
                session.getBasicRemote().sendObject(adminAccusationMessage);
            }
        }
    }

    public synchronized void sendAll(Session session, Object msg) {
        try{
            for(Session s : session.getOpenSessions()) {
                if(s.isOpen()) {
                    s.getBasicRemote().sendObject(msg);
                    logger.log(Level.INFO, "Sent: {0}", msg.toString());
                }
            }
        } catch (Exception e) {
            logger.log(Level.INFO, e.toString());
        }
    }
}
