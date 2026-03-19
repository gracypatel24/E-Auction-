package com.grownited.eauction.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.repository.UserRepository;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Optional<UserEntity> userOpt = userRepository.findByEmail(email);
        
        if (userOpt.isEmpty()) {
            throw new UsernameNotFoundException("User not found with email: " + email);
        }
        
        UserEntity user = userOpt.get();
        
        if (!user.getIsActive()) {
            throw new UsernameNotFoundException("User account is deactivated");
        }
        
        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority("ROLE_" + user.getUserType().getUserTypeName().toUpperCase()));
        
        return new User(user.getEmail(), user.getPassword(), authorities);
    }
}