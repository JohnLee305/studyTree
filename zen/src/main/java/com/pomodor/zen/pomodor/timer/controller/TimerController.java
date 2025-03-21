package com.pomodor.zen.pomodor.timer.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
//import com.pomodor.zen.pomodor.timer.Model.Timer;
import com.pomodor.zen.pomodor.timer.service.TimerService;
import java.util.List;
import java.util.Optional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
@RequestMapping("/zen/pomodor/timer")
public class TimerController {

    @Autowired
    private TimerService timerService;

    
    @GetMapping("hello")
    public String hello(@RequestParam String param) {
        return timerService.sayHello();
    }

    /*
     * @GetMapping("/{id}")
     * public ResponseEntity<Timer> getTimerById(@PathVariable Long id) {
     * Optional<Timer> timer = timerService.findById(id);
     * return timer.map(ResponseEntity::ok).orElseGet(() ->
     * ResponseEntity.notFound().build());
     * }
     * 
     * @GetMapping
     * public List<Timer> getAllTimers() {
     * return timerService.findAll();
     * }
     * 
     * @PutMapping("/{id}")
     * public ResponseEntity<Timer> updateTimer(@PathVariable Long id, @RequestBody
     * Timer timerDetails) {
     * Optional<Timer> timer = timerService.findById(id);
     * if (timer.isPresent()) {
     * Timer updatedTimer = timerService.update(id, timerDetails);
     * return ResponseEntity.ok(updatedTimer);
     * } else {
     * return ResponseEntity.notFound().build();
     * }
     * }
     * 
     * @DeleteMapping("/{id}")
     * public ResponseEntity<Void> deleteTimer(@PathVariable Long id) {
     * if (timerService.existsById(id)) {
     * timerService.deleteById(id);
     * return ResponseEntity.noContent().build();
     * } else {
     * return ResponseEntity.notFound().build();
     * }
     * }
     */
}