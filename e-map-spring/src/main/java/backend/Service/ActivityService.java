package backend.Service;
import backend.Entity.Activity;
import backend.Entity.Jointo;
import backend.Repository.ActivityRepository;
import backend.Repository.JointoRepository;
import net.minidev.json.JSONArray;
import net.minidev.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ActivityService {
    @Autowired
    private ActivityRepository activityRepository;

    @Autowired
    private JointoRepository jointoRepository;

    // 获取全部活动
    public List<Activity> getActivities() {
        return activityRepository.findAll();
    }

    // 通过id寻找活动
    public Activity findActivityById(Long id) {
        return activityRepository.findById(id);
    }

    // 获取推荐活动
    public JSONArray getRecommend() {
        JSONArray result = new JSONArray();
        return result;
    }

    // 获取已参加活动
    public JSONArray getJoined(String name) {
        List<Jointo> jointoList = jointoRepository.findAllByPerson(name);
        JSONArray jsonArray = new JSONArray();
        for(Jointo jointo : jointoList) {
            Activity activity = activityRepository.findById(jointo.getInvolve());
            JSONObject object = new JSONObject();
            object.put("id", activity.getId());
            object.put("name", activity.getName());
            object.put("start", activity.getStart());
            object.put("end", activity.getEnd());
            object.put("sponsor", activity.getSponsor());
            object.put("num", activity.getNum());
            object.put("joined", activity.getJoined());
            object.put("loaction", activity.getLocation());
            object.put("description", activity.getDescription());
            object.put("tags", activity.getTags());
            object.put("status", activity.getStatus());
            jsonArray.add(object);
        }
        return jsonArray;
    }

    // 参加活动
    public JSONObject join(String name, Long id) {
        JSONObject object = new JSONObject();
        if(!activityRepository.existsById(id)) {
            object.put("status", 0);
            object.put("message", "活动不存在！");
            return object;
        }
        Activity activity = activityRepository.findById(id);
        if(activity.getStatus().equals(2)) {
            object.put("status", 0);
            object.put("message", "活动已被封禁！");
            return object;
        }
        if(activity.getJoined() >= activity.getNum()) {
            object.put("status", 0);
            object.put("message", "活动已满员！");
            return object;
        }
        if(jointoRepository.existsByPersonAndInvolve(name, id)) {
            object.put("status", 0);
            object.put("message", "成功参与活动！");
            return object;
        }
        activity.setJoined(activity.getJoined() + 1);
        Jointo jointo = new Jointo(name, id);
        jointoRepository.save(jointo);
        activityRepository.save(activity);
        object.put("status", 1);
        object.put("message", "成功参与活动！");
        return object;
    }

    // 创建活动
    public JSONObject start(Map<String, String> map) {
        JSONObject object = new JSONObject();
        try {
            Activity activity = new Activity();
            activity.setName(map.get("name"));
            activity.setStart(map.get("start"));
            activity.setEnd(map.get("end"));
            activity.setLocation(map.get("location"));
            activity.setTags(map.get("tags"));
            activity.setDescription(map.get("description"));
            activity.setNum(Long.valueOf(map.get("num")));
            activity.setJoined(0L);
            activity.setSponsor(map.get("sponsor"));
            activity.setStatus(0);
            activityRepository.save(activity);
            object.put("status", 1);
            object.put("message", "成功创建活动！");
            return object;
        }catch (Exception e) {
            object.put("status", 0);
            object.put("message", "活动创建失败！");
            return object;
        }
    }

}
