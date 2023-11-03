package javajedik.main.sql;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import javajedik.main.model.ByteFragments;
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
    
    private boolean storeFragments(int picture_id, ByteFragments byteFragments) 
    {
        List<CompletableFuture<Void>> fragmentFutures = new ArrayList<>();

        final String insertFragmentSql = SqlQ.insertFragmentSql();
        
        logger.info("Felkészülés a fragmentek beszúrása. Mentés. A picture_id: " + picture_id);
        
        TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition());
        
        try 
        {
            for (int i = 0; i < byteFragments.getNumberOfFragments(); i++) 
            {
                final int fragmentIndex = i;
                CompletableFuture<Void> future = CompletableFuture.runAsync(() -> 
                {
                    jdbcTemplate.update(insertFragmentSql, picture_id, byteFragments.getNthFragment(fragmentIndex), fragmentIndex);
                });
                fragmentFutures.add(future);
            }

            CompletableFuture<Void> allOf = CompletableFuture.allOf(fragmentFutures.toArray(new CompletableFuture[0]));
            allOf.join();

            final String insertLastFragmentSql = SqlQ.insertLastFragmentSql();
            jdbcTemplate.update(insertLastFragmentSql, picture_id, byteFragments.getLastFragmentValidLength());

            logger.info("Fragmentek beszúrása sikeres. Tranzakció mentése... A picture_id: " + picture_id);
            transactionManager.commit(status);
            return true;
        } catch (Exception e)
        {
            logger.error("Fragmentek beszúrása sikertelen. Tranzakció visszavonása... A picture_id: " + picture_id);
            transactionManager.rollback(status);
            return false;
        }
    }
    
    public int storePicture(ByteFragments byteFragments)
    {
        TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition());
        
        int picture_id = insertNewPicture();
        
        if(picture_id == -1)
        {
            logger.warn("Kép beszúrása sikertelen, tranzakció visszavonása...");
            transactionManager.rollback(status);
            return -1;
        }
        
        if(!storeFragments(picture_id, byteFragments))
        {
            logger.warn("Fragmentek beszúrása közben hiba lépett fel, tranzakció visszavonása...");
            transactionManager.rollback(status);
            return -1;
        }
        
        logger.info("Kép és fragmentek beszúrása  sikeres, tranzakció mentése...");
        transactionManager.commit(status);
        return picture_id;    
    }
}