package com.pomodor.zen;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication
public class ZenApplication {

	public static void main(String[] args) {
		SpringApplication.run(ZenApplication.class, args);
	}

}
