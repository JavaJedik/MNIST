package javajedik.main.service;

import java.util.List;
import javajedik.main.model.PictureData;
import javajedik.main.model.PictureAnswer;
import javajedik.main.model.UploadPictureData;

public interface PictureHandlerService 
{
    public int storePNG(UploadPictureData uploadPictureData);

    public List<PictureData> askPictures(String collectionName, String language, int askedPictures);
    
    public boolean uploadPictureAnswer(PictureAnswer pictureAnswer,int gameId);
}
