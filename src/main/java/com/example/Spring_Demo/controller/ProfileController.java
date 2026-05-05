package com.example.Spring_Demo.controller;

import com.example.Spring_Demo.model.UserAccount;
import com.example.Spring_Demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.validation.Valid;

@Controller
@RequestMapping("/profile")
public class ProfileController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public String showProfile(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();

        UserAccount user = userRepository.findByUserId(username).orElse(null);
        if (user == null) {
            return "redirect:/dashboard";
        }

        model.addAttribute("user", user);
        return "profile";
    }

    @PostMapping
    public String updateProfile(@Valid UserAccount user, BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "profile";
        }

        // Get current user to preserve password and ID
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        UserAccount currentUser = userRepository.findByUserId(auth.getName()).orElse(null);
        if (currentUser != null) {
            user.setId(currentUser.getId());
            user.setPassword(currentUser.getPassword()); // Don't update password here
            user.setRole(currentUser.getRole()); // Don't allow role changes
            userRepository.save(user);
            model.addAttribute("successMessage", "Profile updated successfully!");
        }

        model.addAttribute("user", user);
        return "profile";
    }
}