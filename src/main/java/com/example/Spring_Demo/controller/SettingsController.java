package com.example.Spring_Demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SettingsController {

    @GetMapping("/settings")
    public String showSettings(Model model) {
        model.addAttribute("pageTitle", "Settings");
        model.addAttribute("message", "Account settings will be implemented here.");
        return "generic_page";
    }

    @GetMapping("/support")
    public String showSupport(Model model) {
        model.addAttribute("pageTitle", "Support");
        model.addAttribute("message", "Contact support at support@nesl.com or call 1-800-NESL-HELP.");
        return "generic_page";
    }

    @GetMapping("/notifications")
    public String showNotifications(Model model) {
        model.addAttribute("pageTitle", "Notifications");
        model.addAttribute("message", "You have no new notifications at this time.");
        return "generic_page";
    }
}