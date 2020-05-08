package backend.Controller;

import backend.Entity.Activity;
import backend.Service.ActivityService;
import net.minidev.json.JSONArray;
import net.minidev.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class ActivityController {
    @Autowired
    private ActivityService activityService;


    @RequestMapping(value = "/activities", method = RequestMethod.GET)
    @ResponseBody
    public List<Activity> getActivities() {
        return activityService.getActivities();
    }

    @RequestMapping(value = "/findActivityById", method = RequestMethod.GET)
    @ResponseBody
    public Activity findActivityById(Long id) {
        return activityService.findActivityById(id);
    }

    @RequestMapping(value = "/recommend", method = RequestMethod.GET)
    @ResponseBody
    public JSONArray getRecommend(String name) {
        return activityService.getRecommend();
    }

    @RequestMapping(value = "/joined", method = RequestMethod.GET)
    @ResponseBody
    public JSONArray getJoined(String name) {
        return activityService.getJoined(name);
    }

    @RequestMapping(value = "/join", method = RequestMethod.GET)
    @ResponseBody
    public JSONObject join(String name, Long id) {
        return activityService.join(name, id);
    }

    @RequestMapping(value = "/start", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject start(@RequestBody Map<String, String> map) {
        return activityService.start(map);
    }

    @RequestMapping(value = "/close", method = RequestMethod.GET)
    @ResponseBody
    public JSONObject close(Long id) {
        return activityService.close(id);
    }

    @RequestMapping(value = "/accusation", method = RequestMethod.GET)
    @ResponseBody
    public JSONObject accusation(String name, Long id, String content) {
        return activityService.accusation(name, id, content);
    }

}
