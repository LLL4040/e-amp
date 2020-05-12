package backend.Service;

import net.minidev.json.JSONObject;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class PrizeService {
    private static final Map<Long, JSONObject> roomPrize = new ConcurrentHashMap<>();


    // 产生范围内的随机数
    public static void randomSet(int min, int max, int n, HashSet<Integer> set) {
        if (n > (max - min + 1) || max < min) {
            return;
        }
        for (int i = 0; i < n; i++) {
            // 调用Math.random()方法
            int num = (int) (Math.random() * (max - min)) + min;
            set.add(num);// 将不同的数存入HashSet中
        }
        int setSize = set.size();
        // 如果存入的数小于指定生成的个数，则调用递归再生成剩余个数的随机数，如此循环，直到达到指定大小
        if (setSize < n) {
            randomSet(min, max, n - setSize, set);// 递归
        }
    }

    public synchronized JSONObject involvePrize(String name, Long id) {
        JSONObject object = new JSONObject();
        if(!roomPrize.containsKey(id)) {
            object.put("status", 0);
            object.put("message", "当前活动室不存在抽奖！");
            return object;
        } else {
            List<String> users = (List<String>) roomPrize.get(id).get("joined");
            if(!users.contains(name)) {
                users.add(name);
            }
//            roomPrize.get(id).put("joined", users);
            object.put("status", 1);
            object.put("message", "已参与抽奖！");
            return object;
        }
    }

    public JSONObject watchPrize(Long id) {
        JSONObject object = new JSONObject();
        if(!roomPrize.containsKey(id)) {
            object.put("status", 0);
            object.put("message", "当前活动室不存在抽奖！");
            return object;
        } else {
            return roomPrize.get(id);
        }
    }

    public synchronized JSONObject startPrize(String name, Long id, String prize, Integer num) {
        JSONObject result = new JSONObject();
        if(roomPrize.containsKey(id)) {
            result.put("status", 0);
            result.put("message", "当前活动室已存在抽奖！");
            return result;
        }
        JSONObject object = new JSONObject();
        object.put("starter", name);
        object.put("prize", prize);
        object.put("num", num);
        List<String> users = new ArrayList<>();
        object.put("joined", users);
        roomPrize.put(id, object);
        result.put("status", 1);
        result.put("message", "已发起抽奖！");
        return result;
    }

    public synchronized JSONObject endPrize(Long id) {
        JSONObject object = new JSONObject();
        if(!roomPrize.containsKey(id)) {

            object.put("status", 0);
            object.put("message", "当前活动室不存在抽奖！");
            return object;
        }
        List<String> users = (List<String>) roomPrize.get(id).get("joined");
        Integer num = (Integer) roomPrize.get(id).get("num");
        HashSet<Integer> pl = new HashSet<>();
        randomSet(0, users.size() - 1, num, pl);
        List<String> p = new ArrayList<>();
        for(Integer i : pl) {
            p.add(users.get(i));
        }
        object.put("starter", roomPrize.get(id).get("starter"));
        object.put("prize", roomPrize.get(id).get("prize"));
        object.put("winers", p);
        roomPrize.remove(id);
        return object;
    }
}
