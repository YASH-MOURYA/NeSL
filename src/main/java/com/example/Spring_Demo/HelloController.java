package com.example.Spring_Demo;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class HelloController {

    @GetMapping({"/", "/home"})
    public String showHomePage() {
        return "home";
    }

    @GetMapping("/login")
    public String showLoginPage() {
        return "form";
    }

    @GetMapping("/dashboard")
    public String showDashboard(Model model, Authentication auth) {

        String username = "guest";

        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getName())) {
            username = auth.getName();
            model.addAttribute("roles", auth.getAuthorities());
        }

        model.addAttribute("username", username);

        return "dashboard";
    }

}
