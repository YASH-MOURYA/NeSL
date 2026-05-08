package com.example.Spring_Demo;

import com.example.Spring_Demo.model.UserAccount;
import com.example.Spring_Demo.repository.UserRepository;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Optional;

import static org.mockito.BDDMockito.given;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;


@Disabled
@SpringBootTest

@ActiveProfiles("test")
@AutoConfigureMockMvc(addFilters = false)

class HelloControllerTests {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @MockBean
    private UserRepository userRepository;

    @Test
    void shouldShowLoginPageWhenAccessingRoot() throws Exception {

        mockMvc.perform(get("/"))
                .andExpect(status().isOk())
                .andExpect(view().name("form"));
    }

    @Test
    void shouldShowLoginPageWhenAccessingLogin() throws Exception {

        mockMvc.perform(get("/login"))
                .andExpect(status().isOk())
                .andExpect(view().name("form"));
    }

    @Test
    void shouldRedirectToDashboardWhenLoginIsValid() throws Exception {

        UserAccount user = new UserAccount();

        user.setId(1);
        user.setUserId("entity1");
        user.setPassword(passwordEncoder.encode("entity123"));
        user.setRole("ENTITY");

        given(userRepository.findByUserId("entity1"))
                .willReturn(Optional.of(user));

        mockMvc.perform(post("/perform_login")
                        .param("userId", "entity1")
                        .param("password", "entity123"))
                .andExpect(status().is3xxRedirection());
    }

    @Test
    void shouldRedirectToLoginWhenLoginIsInvalid() throws Exception {

        given(userRepository.findByUserId("wrong"))
                .willReturn(Optional.empty());

        mockMvc.perform(post("/perform_login")
                        .param("userId", "wrong")
                        .param("password", "wrong"))
                .andExpect(status().is3xxRedirection());
    }

    @Test
    @WithMockUser(username = "entity1", roles = {"ENTITY"})
    void shouldShowDashboardWhenUserIsAuthenticated() throws Exception {

        mockMvc.perform(get("/dashboard"))
                .andExpect(status().isOk())
                .andExpect(view().name("dashboard"));
    }
}