package backend.WebSocket;

import backend.Entity.Talk;
import backend.Repository.TalkRepository;
import backend.WebSocket.Message.Decoder.ChatDecoder;
import backend.WebSocket.Message.Decoder.RoomDecoder;
import backend.WebSocket.Message.Encoder.*;
import backend.WebSocket.Message.Entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

@Component
@ServerEndpoint(
        value = "/websocket/api/user",
        decoders = {
                ChatDecoder.class
        },
        encoders = {
                InviteMessageEncoder.class,
                TalkMessageEncoder.class,
                SystemMessageEncoder.class
        }
)
public class ChatServer {
    private static final Map<String, Session> users = new ConcurrentHashMap<>();
    private static Logger logger = Logger.getLogger("websocket");

    private TalkRepository talkRepository = (TalkRepository) ApplicationHelper.getBean("talkRepository");

    @OnOpen
    public void openConnection(Session session) {
        logger.log(Level.INFO, "Connection opened.");
    }

    @OnMessage
    public void message(Session session, Message msg) throws IOException, EncodeException {
        logger.log(Level.INFO, "Received: {0}", msg.toString());
        if(msg instanceof JoinMessage) {
            /* add the new admin */
            JoinMessage jmsg = (JoinMessage) msg;
            users.put(jmsg.getUser(), session);
            logger.log(Level.INFO, "Received: {0}", jmsg.toString());
            if(talkRepository.existsByToAndStatus(jmsg.getUser(), 1)) {
                List<Talk> talkList1 = talkRepository.findAllByToAndStatus(jmsg.getUser(), 1);
                for(Talk talk : talkList1) {
                    session.getBasicRemote().sendObject(new ChatMessage(talk.getFrom(), talk.getTo(),talk.getWhen(), talk.getContent()));
                    talk.setStatus(0);
                    talkRepository.save(talk);
                }
            }
            if(talkRepository.existsByToAndStatus(jmsg.getUser(), 2)) {
                List<Talk> talkList2 = talkRepository.findAllByToAndStatus(jmsg.getUser(), 2);
                for(Talk talk : talkList2) {
                    session.getBasicRemote().sendObject(new SystemMessage(talk.getTo(), talk.getContent(), talk.getWhen()));
                    talk.setStatus(0);
                    talkRepository.save(talk);
                }
            }
        } else if (msg instanceof ChatMessage) {
            ChatMessage cmsg = (ChatMessage) msg;
            logger.log(Level.INFO, "Received: {0}", cmsg.toString());
            if(!users.containsKey(cmsg.getTo())) {
                Talk talk = new Talk(cmsg.getFrom(), cmsg.getTo(), cmsg.getTime(), cmsg.getMessage(), 1);
                talkRepository.save(talk);
            } else {
                users.get(cmsg.getTo()).getBasicRemote().sendObject(cmsg);
            }
        } else if (msg instanceof InviteMessage) {
            InviteMessage imsg = (InviteMessage) msg;
            logger.log(Level.INFO, "Received: {0}", imsg.toString());
            if(!users.containsKey(imsg.getTo())) {
                Talk talk = new Talk(imsg.getFrom(), imsg.getTo(), imsg.getTime(), imsg.getMessage(), 1);
                talkRepository.save(talk);
            } else {
                users.get(imsg.getTo()).getBasicRemote().sendObject(imsg);
            }
        } else if (msg instanceof SystemMessage) {
            SystemMessage smsg = (SystemMessage) msg;
            logger.log(Level.INFO, "Received: {0}", smsg.toString());
            if(!users.containsKey(smsg.getUser())) {
                Talk talk = new Talk("System", smsg.getUser(), smsg.getTime(), smsg.getContent(), 2);
                talkRepository.save(talk);
            } else {
                users.get(smsg.getUser()).getBasicRemote().sendObject(smsg);
            }
        }
    }

    @OnClose
    public void disConnect(Session session) {
        users.values().removeIf(session1 -> session1.equals(session));
        logger.log(Level.INFO, "Connection closed.");
    }

}
