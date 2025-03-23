package com.pomodor.zen.pomodor.timer.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.RequestMapping;
import com.pomodor.zen.pomodor.timer.service.TimerService;

@Controller
@RequestMapping("/zen/pomodor/timer")
public class TimerController {

    @Autowired
    private TimerService timerService;

    @GetMapping("hello.do")
    public String hello(@RequestParam(value = "param", required = false, defaultValue = "World") String param,
            Model model) {
        model.addAttribute("param", param);
        return "timer/hello"; // This will resolve to /WEB-INF/views/hello.js
    }

    @GetMapping("timermain.do")
    public String timerMain(@RequestParam(value = "param", required = false, defaultValue = "World") String param,
            Model model) {
        model.addAttribute("WORK_BACKGROUND_IMAGE", "/img/study.gif");
        model.addAttribute("BREAK_BACKGROUND_IMAGE", "/img/break.jpg");
        model.addAttribute("param", param);
        return "timer/timermain";
    }
}