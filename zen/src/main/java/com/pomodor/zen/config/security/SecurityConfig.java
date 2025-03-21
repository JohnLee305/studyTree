package com.pomodor.zen.config.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/hello").permitAll() // 모든 경로에 대해 인증 없이 접근 허용
                        .anyRequest().authenticated())
                .formLogin(form -> form.disable()) // 로그인 폼 비활성화
                .httpBasic(httpBasic -> httpBasic.disable()); // 기본 HTTP 인증 비활성화

        return http.build();
    }
}