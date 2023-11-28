package javajedik.main.sql;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;
import javajedik.main.model.AnswerOption;
import javajedik.main.model.PictureData;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

@Repository
public class PictureHandlerSQL 
{
    private static final Logger logger = LogManager.getLogger(PictureHandlerSQL.class);
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @Autowired
    private DataSourceTransactionManager transactionManager;
    
    private int insertNewPicture() 
    {
        final String insertSql = "insert into picture values ()";
        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> 
        {
            PreparedStatement ps = connection.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
            return ps;
        }, keyHolder);

        Number key = keyHolder.getKey();
        if (key != null) 
        {
            logger.info("Új képazonosító beszúrása sikeres, a picture_id: " + key);
            return key.intValue();
        } else 
        {
            logger.error("Új képazonosító beszúrása sikertelen");
            return -1;
        }
    }
    
    private void storeBinData(int picture_id, byte[] pictureBytes) throws Exception
    {

        final String insertFragmentSql = SqlQ.insertFragmentSql();
        
        logger.info("Felkészülés a kép binárisának beszúrása. A picture_id: " + picture_id);
        
        jdbcTemplate.update(insertFragmentSql, picture_id, pictureBytes);

        logger.info("A bináris beszúrása sikeres. A picture_id: " + picture_id);
    }
    
    private int storePictureRealOptions(int pictureId, int answerCollectionId) throws Exception
    {
        final String insertSql = "INSERT INTO picture_real_options (picture_id, answer_collection_id) VALUES (?, ?)";
        
        int rowsAffected = jdbcTemplate.update(insertSql, pictureId, answerCollectionId);
        
        if (rowsAffected > 0) {
            logger.info("A picture_real_options táblába történő beszúrás sikeres.");
            return rowsAffected;
        } else 
        {
            logger.warn("Nem sikerült beszúrni az adatokat a picture_real_options táblába.");
            return -1;
        }
    }
    
    public int storePicture(PictureData pictureData)
    {
        TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition());
        
        pictureData.setPictureId(insertNewPicture());
        
        if(pictureData.getPictureId() == -1)
        {
            logger.warn("Kép beszúrása sikertelen, tranzakció visszavonása...");
            transactionManager.rollback(status);
            return -1;
        }
        
        try
        {
            storeBinData(pictureData.getPictureId(), pictureData.getPictureBytes());
            logger.info("Kép fragmentjeinek beszúrása sikeres, picture_id : " + pictureData.getPictureId());
            
            storePictureRealOptions(pictureData.getPictureId(), 1); // 1 az answer_collection_id fix értéke
            logger.info("A picture_real_options táblába történő beszúrás sikeres, picture_id : " + pictureData.getPictureId());
        } catch (Exception e)
        {
            logger.warn("Fragment beszúrása közben hiba lépett fel, tranzakció visszavonása...");
            transactionManager.rollback(status);
            return -1;
        }
        
        logger.info("Kép és fragment beszúrása  sikeres, tranzakció mentése...");
        transactionManager.commit(status);
        return pictureData.getPictureId();    
    }
    
    public List<PictureData> getNumberPicture(int askedPictures) 
    {
        final String selectSql = "SELECT picture_id, bin_data FROM picture_bin_data LIMIT ?";

        List<PictureData> result = jdbcTemplate.query
        (
            selectSql,
            new Object[]{askedPictures},
            (rs, rowNum) -> 
            {
                int pictureId = rs.getInt("picture_id");
                byte[] binData = rs.getBytes("bin_data");
                return new PictureData(pictureId, binData);
            }
        );

        if(result.isEmpty() || result == null)
        {
            logger.warn("Nem sikerült képet szerezni az adatbázisból");
        } else
        {
            logger.info("Sikerült képeket szerezni az adatbázisból");
        }
        
        // KÉSŐBB CSERÉLNI KELL!!!
        for(int i = 0; i<result.size();i++)
        {
            AnswerOption[] ao = new AnswerOption[10];
            for(int j=0;j<10;j++)
            {
                ao[j]=new AnswerOption(j+1,"Szám",(j+1)+"");
            }
            ao[9]=new AnswerOption(10,"Szám","0");
            result.get(i).setAnswerOptions(ao);
            result.get(i).setPictureAnswerNickname("Szám");
        }
        return result;
    }
}