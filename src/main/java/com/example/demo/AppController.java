package com.example.demo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class AppController {
    @Value("${app.environment}")
    private String environment;

    @Value("${app.external.config}")
    private String externalConfig;

    @Value("${HOSTNAME:NA}")
    private String podName;

    @GetMapping("/info")
    public Map<String, String> getAppInfo() {
        Map<String, String> response = new HashMap<>();
        response.put("environment", environment);
        response.put("externalConfig", externalConfig);
        response.put("podName", podName);
        return response;
    }
}
