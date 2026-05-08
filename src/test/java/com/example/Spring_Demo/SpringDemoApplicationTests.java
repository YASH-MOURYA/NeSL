package com.example.Spring_Demo;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;



@SpringBootTest
@Disabled
@ActiveProfiles("test")
class SpringDemoApplicationTests {

    @Test
    void contextLoads() {

    }
}