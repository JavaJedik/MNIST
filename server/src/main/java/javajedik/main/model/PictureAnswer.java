package javajedik.main.model;

public  class PictureAnswer 
{
    private String pictureId;
    private String answerId;

    public String getPictureId() 
    {
        return pictureId;
    }

    public void setPictureId(String pictureId) 
    {
        this.pictureId = pictureId;
    }

    public String getAnswerId() 
    {
        return answerId;
    }

    public void setAnswerId(String answerId) 
    {
        this.answerId = answerId;
    }
    
    @Override
    public String toString() 
    {
        return "PictureAnswer{" + "pictureId='" + pictureId + "', answerId='" + answerId + "'}";
    }
}