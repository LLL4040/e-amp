package backend.Entity;

import java.util.HashMap;
import java.util.Map;

public class ActivityRecommend {
    private Activity activity;
    private Map<String, Double> activityTagMap;
    private Double distance;

    public ActivityRecommend(Activity activity) {
        this.activity = activity;
        this.activityTagMap = new HashMap<>();
        String[] splits = activity.getTags().replace(" ", "").split(",");
        for(String split : splits) {
            activityTagMap.put(split, activityTagMap.getOrDefault(split, (double) 0) + 1);
        }
        Integer num = splits.length;
        for(String split : splits) {
            if(activityTagMap.get(split) >= 1) {
                activityTagMap.put(split, activityTagMap.get(split) / num);
            }
        }
    }

    public Activity getActivity() {
        return activity;
    }

    public Double getDistance() {
        return distance;
    }

    public Map<String, Double> getActivityTagMap() {
        return activityTagMap;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public void setActivityTagMap(Map<String, Double> activityTagMap) {
        this.activityTagMap = activityTagMap;
    }

    public void setDistance(Double distance) {
        this.distance = distance;
    }

    @Override
    public String toString() {
        return "ActivityRecommend{" +
                "distance=" + distance +
                '}';
    }
}
