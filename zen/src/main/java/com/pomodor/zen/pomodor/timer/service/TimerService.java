package com.pomodor.zen.pomodor.timer.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TimerService {

    @Autowired
    public String sayHello() {
        return "Hello";
    }

}