package javajedik.main.restcontroller;

import java.util.List;
import javajedik.main.model.PictureData;
import javajedik.main.model.PictureAnswer;
import javajedik.main.service.PictureHandlerService;
import javajedik.main.util.GameTokenUtil;
import javajedik.main.util.ImageUtil;
import javajedik.main.util.LanguageDict;
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

    @GetMapping("/ask/picture")
    public ResponseEntity<List<PictureData>> askPictures (
            @RequestHeader("gameToken") String gameToken, 
            @RequestHeader("collectionName") String collectionName,
            @RequestHeader("language") String language,
            @RequestHeader("numberOfAskedPictures") String numberOfAskedPicturesString)
    {
        if(false && !GameTokenUtil.validateToken(gameToken))
        {
            logger.warn("Invalid gameToken");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        
        language = LanguageDict.getLanguage(language);
        
        logger.info("CollectionName: " + collectionName + ", Language: " + language + ", NumberOfAskedPictures: " + numberOfAskedPicturesString);
                
        List<PictureData> data = pictureHandlerService.askPictures(collectionName,language,Integer.parseInt(numberOfAskedPicturesString));
        
        if(data == null || data.isEmpty())
        {
            logger.error("Nincs kép az adatbázisban vagy nem kérhető le");
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
        
        logger.info("Képek megszerezve, küldés a kliensnek... Képek száma: " + data.size());
        try
        {
            logger.info("Képek felépítésének megpróbálása küldés előtt...");
            ImageUtil.convertToPNG(data.get(0).getPictureBytes());
        } catch (Exception e)
        {
            logger.error("Kép felépítése sikertelen, internal server error küldése.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(data);
        }
        
        //logger.info("A képek adatai: " + data.get(1).getAnswerOptions().length);
        return ResponseEntity.status(HttpStatus.OK).body(data);
    }
    
    @PostMapping("/upload/answer/picture")
    public ResponseEntity<String> uploadPictureAnswer(
            @RequestHeader("gameToken") String gameToken,
            @RequestBody PictureAnswer pictureAnswer) {
        if (!GameTokenUtil.validateToken(gameToken)) {
            logger.info("Invalid gameToken");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        
        logger.info("A feltölteni kívánt kép és válasz: " + pictureAnswer);
        
        if(pictureHandlerService.uploadPictureAnswer(pictureAnswer,GameTokenUtil.getGameId(gameToken))) 
        {
            return ResponseEntity.status(HttpStatus.OK).body("A képre adott válasz feltöltése sikeres: " + pictureAnswer);
        }
        
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("A képre adott válasz feltöltése sikertelen: " + pictureAnswer);
    }
}