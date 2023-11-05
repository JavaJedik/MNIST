package javajedik.main.util;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import javax.imageio.ImageIO;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class ImageUtil 
{
    private static final Logger logger = LogManager.getLogger(ImageUtil.class);

    public static byte[] convertToPNG(byte[] imageData) 
    {
        try 
        {
            ByteArrayInputStream inputStream = new ByteArrayInputStream(imageData);
            BufferedImage image = ImageIO.read(inputStream);

            if (image == null) 
            {
                throw new Exception("Nem sikerült a kép felépítése.");
            }

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();            
            ImageIO.write(image, "png", outputStream);

            logger.info("Kép felépítése sikeres, byteArray készítése...");
            return outputStream.toByteArray();
        } catch (Exception e) 
        {
            logger.error("Hiba történt a kép konvertálása során: ",e);
            return null;
        }
    }
}
