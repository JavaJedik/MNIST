package javajedik.main.sql;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;
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
    
    private void storeFragments(int picture_id, byte[] pictureBytes) throws Exception
    {

        final String insertFragmentSql = SqlQ.insertFragmentSql();
        
        logger.info("Felkészülés a kép binárisának beszúrása. A picture_id: " + picture_id);
        
        jdbcTemplate.update(insertFragmentSql, picture_id, pictureBytes);

        logger.info("A bináris beszúrása sikeres. A picture_id: " + picture_id);
    }
    
    public int storePicture(byte[] pictureBytes)
    {
        TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition());
        
        int picture_id = insertNewPicture();
        
        if(picture_id == -1)
        {
            logger.warn("Kép beszúrása sikertelen, tranzakció visszavonása...");
            transactionManager.rollback(status);
            return -1;
        }
        
        try
        {
            storeFragments(picture_id, pictureBytes);
        } catch (Exception e)
        {
            logger.warn("Fragment beszúrása közben hiba lépett fel, tranzakció visszavonása...");
            transactionManager.rollback(status);
            return -1;
        }
        
        logger.info("Kép és fragment beszúrása  sikeres, tranzakció mentése...");
        transactionManager.commit(status);
        return picture_id;    
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
        
        return result;
    }
}