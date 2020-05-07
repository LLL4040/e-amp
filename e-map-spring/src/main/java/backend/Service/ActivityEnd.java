package backend.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

@Component
@EnableScheduling
public class ActivityEnd {
    @Autowired
    private ActivityService activityService;

    @Scheduled(fixedRate = 300000)
    public void scheduleTask() {
        activityService.seekAndEnd();
    }
}
