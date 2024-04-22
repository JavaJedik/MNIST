package javajedik.main.restcontroller;

import javajedik.main.model.UploadPictureData;
import javajedik.main.util.ImageUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import javajedik.main.util.UserTokenUtil;
import org.springframework.web.bind.annotation.RequestHeader;
import javajedik.main.service.PictureHandlerService;
import javajedik.main.util.LanguageDict;

@RestController
@RequestMapping("/upload")
public class UploadController 
{
    private static final Logger logger = LogManager.getLogger(UploadController.class);
    
    @Autowired
    private PictureHandlerService uploadPictureService;
    
    @PostMapping("/picture")
    public ResponseEntity<String> uploadPicture(
            @RequestHeader("userToken") String userToken,
            @RequestHeader("language") String language,
            @RequestHeader("collectionType") String collectionType,
            @RequestHeader("pictureType") String pictureType,
            @RequestHeader("pictureAnswer") String pictureAnswer,
            @RequestBody byte[] binaryData)
    {   
        pictureType = pictureType.replaceAll("^\"|\"$", "");
        pictureAnswer = pictureAnswer.replaceAll("^\"|\"$", "");
        
        logger.info("Egy userToken és byte[] érkezett, validáció megkezdése...");
        logger.info("A kép válaszának kollekciója, típusa és értéke: " + collectionType + ", " + pictureType + ", " + pictureAnswer);
        
        final int player_id = UserTokenUtil.getPlayerId(userToken);
        
        if(player_id == -1)
        {
            logger.warn("A userToken érvénytelen, http 401 küldése: " + userToken);
            return ResponseEntity.status(HttpStatus.OK).build();
        }
        
        long fileSizeInBytes = binaryData.length;
        long fileSizeInMB = fileSizeInBytes / (1024 * 1024); // Byte-okból Megabyte-okká
        if (fileSizeInMB > 100) 
        {
            logger.warn("Túl nagy a kép méréte, http 413 küldése...");
            return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE).body("A kép mérete meghaladja a 100 MB-ot.");
        }
        
        binaryData = ImageUtil.convertToPNG(binaryData);
        
        if(binaryData == null)
        {
            logger.warn("A kép biztonságos feldolgozása sikertelen, http 406 küldése...");
            return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body("A kép biztonságos feldolgozása sikertelen.");
        }
        
        language = LanguageDict.getLanguage(language);
        
        UploadPictureData uploadPictureData = new UploadPictureData(language, collectionType, pictureType, pictureAnswer, binaryData);
        final int picture_id = uploadPictureService.storePNG(uploadPictureData);
        
        if(picture_id==-1)
        {
            return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body("A kollekció nem létezik vagy a válasz nem eleme.");
        }
                
        return ResponseEntity.status(HttpStatus.OK).body("A képazonosítód: " + picture_id);
    }
}