package javajedik.main.controller;

import javajedik.main.model.LoginData;
import javajedik.main.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/login")
public class LoginRest 
{
    @Autowired
    LoginService loginService;
    
    @PostMapping("/")
    public ResponseEntity<LoginData> tryToLogin(@RequestBody LoginData ld) 
    {
        loginService.authenticateUser(ld);
        return new ResponseEntity<>(ld, HttpStatus.OK);
    }

}
