package javajedik.main.model;

public class UploadPictureData 
{
    String language;
    String collectionType;
    String pictureType;
    String pictureAnswer;
    byte[] pictureBytes;
    int collection_id;

    public int getCollection_id() {
        return collection_id;
    }

    public void setCollection_id(int collection_id) {
        this.collection_id = collection_id;
    }

    public UploadPictureData(String language, String collectionType, String pictureType, String pictureAnswer, byte[] binaryData) {
        this.language = language;
        this.collectionType = collectionType;
        this.pictureType = pictureType;
        this.pictureAnswer = pictureAnswer;
        this.pictureBytes = binaryData;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getCollectionType() {
        return collectionType;
    }

    public void setCollectionType(String collectionType) {
        this.collectionType = collectionType;
    }

    public String getPictureType() {
        return pictureType;
    }

    public void setPictureType(String pictureType) {
        this.pictureType = pictureType;
    }

    public String getPictureAnswer() {
        return pictureAnswer;
    }

    public void setPictureAnswer(String pictureAnswer) {
        this.pictureAnswer = pictureAnswer;
    }

    public byte[] getPictureBytes() {
        return pictureBytes;
    }

    public void setPictureBytes(byte[] pictureBytes) {
        this.pictureBytes = pictureBytes;
    }
}
