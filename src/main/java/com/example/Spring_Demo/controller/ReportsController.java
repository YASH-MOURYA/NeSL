package com.example.Spring_Demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReportsController {

    @GetMapping("/reports")
    public String showReports(Model model) {
        model.addAttribute("pageTitle", "Reports");
        model.addAttribute("message", "Reports functionality will be implemented here.");
        return "generic_page";
    }
}