package javajedik.main.service;

import java.util.List;
import javajedik.main.model.PictureData;

public interface PictureHandlerService 
{
    public int storePNG(PictureData pictureData);

    public List<PictureData> askNumberPicture(int askedPictures);
}
