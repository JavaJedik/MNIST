/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package javajedik.main.service.imp;

import java.util.List;
import javajedik.main.model.PictureData;
import javajedik.main.sql.PictureHandlerSQL;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javajedik.main.service.PictureHandlerService;

@Service
public class PictureHandlerServiceImp implements PictureHandlerService 
{
    private static final Logger logger = LogManager.getLogger(PictureHandlerService.class);
    
    @Autowired
    private PictureHandlerSQL pictureHandlerSQL;

    @Override
    public int storePNG(byte[] pngBytes) 
    {   
        final int picture_id = pictureHandlerSQL.storePicture(pngBytes);
        
        if(picture_id == -1)
        {
            logger.warn("Kép beszúrása sikertelen... -1 visszaadása");
            return -1;
        } else
        {
            logger.info("Kép beszúrása sikeres, picture_id: " + picture_id);
            return picture_id;
        }
    }

    @Override
    public List<PictureData> askNumberPicture(int askedPictures) 
    {
        List<PictureData> data = pictureHandlerSQL.getNumberPicture(askedPictures);
        
        if(data.isEmpty() || data == null)
        {
            logger.warn("Nem sikerült az adatbázisrétegből megszerezni a képeket");
        } else
        {
            logger.info("Az adatbázis sikeresen elküldte a képeket");
        }
        
        return data;
    }
}
