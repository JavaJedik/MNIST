package javajedik.main.model;

public class PictureData 
{
    int pictureId;
    byte[] pictureBytes;

    public PictureData(int pictureId, byte[] pictureBytes) 
    {
        this.pictureId = pictureId;
        this.pictureBytes = pictureBytes;
    }

    public int getPictureId() 
    {
        return pictureId;
    }

    public byte[] getPictureBytes() 
    {
        return pictureBytes;
    }
}
