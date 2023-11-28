package javajedik.main.model;

public class PictureData 
{
    int pictureId;
    byte[] pictureBytes;
    String pictureAnswerNickname;
    AnswerOption[] answerOptions;

    public PictureData(byte[] pictureBytes) 
    {
        this.pictureBytes = pictureBytes;
    }
    
    public PictureData(int pictureId, byte[] pictureBytes) 
    {
        this.pictureId = pictureId;
        this.pictureBytes = pictureBytes;
    }

    public void setPictureId(int pictureId) 
    {
        this.pictureId = pictureId;
    }

    public void setPictureAnswerNickname(String pictureAnswerNickname) 
    {
        this.pictureAnswerNickname = pictureAnswerNickname;
    }

    public AnswerOption[] getAnswerOptions() 
    {
        return answerOptions;
    }

    public void setAnswerOptions(AnswerOption[] answerOptions) 
    {
        this.answerOptions = answerOptions;
    }
    
    public String getPictureAnswerNickname() 
    {
        return pictureAnswerNickname;
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
