package javajedik.main.restcontroller;

import java.util.List;
import javajedik.main.model.PictureData;
import javajedik.main.service.LoginService;
import javajedik.main.service.PictureHandlerService;
import javajedik.main.util.GameTokenUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/game")
public class GamePictureController 
{
    private static final Logger logger = LogManager.getLogger(LoginController.class);
    
    @Autowired
    private PictureHandlerService pictureHandlerService;

    @GetMapping("/ask/picture/number")
    public ResponseEntity<List<PictureData>> askNumberPicture (@RequestHeader("gameToken") String gameToken)
    {
        if(!GameTokenUtil.validateToken(gameToken))
        {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        
        List<PictureData> data = pictureHandlerService.askNumberPicture(5);
        
        if(data == null || data.isEmpty())
        {
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
        
        return ResponseEntity.status(HttpStatus.OK).body(data);
    }
}
