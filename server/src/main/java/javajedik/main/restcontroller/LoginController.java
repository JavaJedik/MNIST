package javajedik.main.restcontroller;

import javajedik.main.model.LoginData;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/login")
public class LoginController 
{

    private static final String userToken = "EzIttAUserToken"; // Konstans userToken

    @PostMapping("/")
    public ResponseEntity<String> loginUser(@RequestBody LoginData loginData) 
    {
        // Ide kerülhet a hitelesítési logika a loginData objektum alapján
        // Jelenleg csak kiírjuk a konzolra a felhasználónevet és jelszót
        System.out.println("Felhasználónév: " + loginData.getUsername());
        System.out.println("Jelszó: " + loginData.getPassword());

        return ResponseEntity.ok(userToken);
    }
}