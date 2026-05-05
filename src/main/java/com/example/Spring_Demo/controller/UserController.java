package com.example.Spring_Demo.controller;

import com.example.Spring_Demo.model.UserAccount;
import com.example.Spring_Demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.NonNull;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.validation.Valid;

@Controller
@RequestMapping("/users")
@PreAuthorize("hasRole('ADMIN') or hasRole('MANAGER')")
public class UserController {

    private final UserRepository userRepository;

    @Autowired
    public UserController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping
    public String listUsers(Model model) {
        model.addAttribute("users", userRepository.findAll());
        return "users";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("user", new UserAccount());
        model.addAttribute("roles", new String[]{"ENTITY", "IRP", "INDIVIDUAL", "GOVT", "AOP", "MANAGER"});
        return "user_form";
    }

    @PostMapping
    public String saveUser(@Valid @ModelAttribute("user") @NonNull UserAccount user, BindingResult result) {
        if (result.hasErrors()) {
            return "user_form";
        }
        userRepository.save(user);
        return "redirect:/users";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") @NonNull Integer id, Model model) {
        UserAccount user = userRepository.findById(id).orElse(null);
        if (user == null) {
            return "redirect:/users";
        }
        model.addAttribute("user", user);
        model.addAttribute("roles", new String[]{"ENTITY", "IRP", "INDIVIDUAL", "GOVT", "AOP", "MANAGER"});
        return "user_form";
    }

    @GetMapping("/delete/{id}")
    public String deleteUser(@PathVariable("id") @NonNull Integer id) {
        userRepository.deleteById(id);
        return "redirect:/users";
    }
}
