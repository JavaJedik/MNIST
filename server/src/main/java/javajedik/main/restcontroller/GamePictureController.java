package javajedik.main.restcontroller;

import java.util.List;
import javajedik.main.model.PictureData;
import javajedik.main.service.PictureHandlerService;
import javajedik.main.util.GameTokenUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
    public ResponseEntity<List<PictureData>> askNumberPicture (@RequestHeader("gameToken") String gameToken, @RequestHeader("numberOfAskedPictures") String numberOfAskedPicturesString)
    {
        if(!GameTokenUtil.validateToken(gameToken))
        {
            logger.warn("Invalid gameToken");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        
        List<PictureData> data = pictureHandlerService.askNumberPicture(Integer.parseInt(numberOfAskedPicturesString));
        
        if(data == null || data.isEmpty())
        {
            logger.error("Nincs kép az adatbázisban vagy nem kérhető le");
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
        
        logger.info("Képek megszerezve, küldés a kliensnek...");
        return ResponseEntity.status(HttpStatus.OK).body(data);
    }
    
    @PostMapping("/upload/answer/picture")
    public ResponseEntity<String> uploadPictureAnswer (
            @RequestHeader("gameToken") String gameToken,
            @RequestBody String playerAnswer)
    {
        if(!GameTokenUtil.validateToken(gameToken))
        {
            logger.info("Invalid gameToken");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        
        logger.info("A képre adott válasz feltöltése sikeres");
        return ResponseEntity.status(HttpStatus.OK).build();
    }
}
