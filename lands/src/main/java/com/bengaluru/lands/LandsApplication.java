package com.bengaluru.lands;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
@ServletComponentScan
public class LandsApplication {
    public static void main(String[] args) {
        SpringApplication.run(LandsApplication.class, args);
    }
}