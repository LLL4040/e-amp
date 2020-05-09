package backend.Controller;

import backend.Service.UserService;
import net.minidev.json.JSONArray;
import net.minidev.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject register(@RequestBody Map<String, String> map) {
        String name = map.get("name");
        String phone = map.get("phone");
        String password = map.get("password");
        return userService.register(name, phone, password);
    }

    @RequestMapping(value = "/admin/register", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject registerAdmin(@RequestBody Map<String, String> map) {
        String name = map.get("name");
        String password = map.get("password");
        return userService.registerAdmin(name, password);
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject login(@RequestBody Map<String, String> map) {
        String name = map.get("name");
        String password = map.get("password");
        return userService.login(name, password);
    }

    @RequestMapping(value = "/admin/login", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject loginAdmin(@RequestBody Map<String, String> map) {
        String name = map.get("name");
        String password = map.get("password");
        return userService.loginAdmin(name, password);
    }

    @RequestMapping(value = "/message", method = RequestMethod.GET)
    @ResponseBody
    public JSONObject getUserMessage(String name) {
        return userService.getUserMessage(name);
    }

    @RequestMapping(value = "/friendList", method = RequestMethod.GET)
    @ResponseBody
    public JSONArray getFriendList(String name) {
        return userService.getFriendList(name);
    }

    @RequestMapping(value = "/addFriend", method = RequestMethod.GET)
    @ResponseBody
    public JSONObject addFriend(String name, String friend) {
        return userService.addFriend(name, friend);
    }
}
