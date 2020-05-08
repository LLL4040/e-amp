package backend.Controller;

import backend.Entity.Activity;
import backend.Service.PrizeService;
import net.minidev.json.JSONArray;
import net.minidev.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class PrizeController {
    @Autowired
    private PrizeService prizeService;

    @RequestMapping(value = "/startPrize", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject startPrize(@RequestBody Map<String, String> map) {
        String name = map.get("name");
        Long id = Long.valueOf(map.get("id"));
        String prize = map.get("prize");
        Integer num = Integer.valueOf(map.get("num"));
        return prizeService.startPrize(name, id, prize, num);
    }

    @RequestMapping(value = "/watchPrize", method = RequestMethod.GET)
    @ResponseBody
    public JSONObject watchPrize(Long id) {
        return prizeService.watchPrize(id);
    }

    @RequestMapping(value = "/involvePrize", method = RequestMethod.GET)
    @ResponseBody
    public JSONObject involvePrize(String name, Long id) {
        return prizeService.involvePrize(name, id);
    }

    @RequestMapping(value = "/endPrize", method = RequestMethod.GET)
    @ResponseBody
    public JSONObject endPrize(Long id) {
        return prizeService.endPrize(id);
    }
}
