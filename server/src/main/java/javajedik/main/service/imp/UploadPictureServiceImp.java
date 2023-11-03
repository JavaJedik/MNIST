/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package javajedik.main.service.imp;

import javajedik.main.model.ByteFragments;
import javajedik.main.service.UploadPictureService;
import javajedik.main.sql.PictureHandlerSQL;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UploadPictureServiceImp implements UploadPictureService 
{
    private static final Logger logger = LogManager.getLogger(UploadPictureService.class);
    
    @Autowired
    private PictureHandlerSQL pictureHandlerSQL;

    @Override
    public boolean storePNG(byte[] pngBytes) 
    {
        ByteFragments byteFragments = new ByteFragments(pngBytes, 255);
        
        return pictureHandlerSQL.storePicture(byteFragments);
    }
    
}
