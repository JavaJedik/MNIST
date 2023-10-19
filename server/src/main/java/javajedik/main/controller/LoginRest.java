package javajedik.main.controller;

import javajedik.main.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;

@RestController
@RequestMapping("/login")
public class LoginRest 
{
    @Autowired
    LoginService loginservice;
    
    @PostMapping("/")
    public String tryToLogin(@RequestBody LoginData ld)
    {
        loginService.isValidLoginData(ld);
        return new ResponseEntity<>(c, HttpStatus.OK);
    }
}
