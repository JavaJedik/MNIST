/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package javajedik.main.service.imp;

import javajedik.main.sql.PictureHandlerSQL;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javajedik.main.service.PictureUploadHandlerService;

@Service
public class PictureUploadHandlerServiceImp implements PictureUploadHandlerService 
{
    private static final Logger logger = LogManager.getLogger(PictureUploadHandlerService.class);
    
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
    
}
