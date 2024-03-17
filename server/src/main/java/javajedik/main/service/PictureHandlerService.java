package javajedik.main.service;

import java.util.List;
import javajedik.main.model.PictureData;
import javajedik.main.model.PictureAnswer;

public interface PictureHandlerService 
{
    public int storePNG(PictureData pictureData);

    public List<PictureData> askNumberPicture(int askedPictures);
    
    public boolean uploadPictureAnswer(PictureAnswer pictureAnswer,int gameId);
}
