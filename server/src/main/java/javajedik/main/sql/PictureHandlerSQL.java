package javajedik.main.sql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Stream;
import javajedik.main.model.AnswerOption;
import javajedik.main.model.CollectionData;
import javajedik.main.model.PictureAnswer;
import javajedik.main.model.PictureData;
import javajedik.main.model.UploadPictureData;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
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
    
    private int getCollectionIdByName(UploadPictureData uploadPictureData) {
        final String selectSql = "SELECT answer_collection.id " +
                                 "FROM answer_collection " +
                                 "JOIN answer_collection_wordlist ON answer_collection_wordlist.id = answer_collection.answer_collection_wordlist_id " +
                                 "JOIN answer_collection_wordlist_international ON answer_collection_wordlist_international.answer_collection_wordlist_id = answer_collection_wordlist.id " +
                                 "JOIN language ON language.id = answer_collection_wordlist_international.language_id " +
                                 "JOIN language_name ON language.id = language_name.language_id " +
                                 "WHERE language_name.name = ? AND answer_collection_wordlist_international.word = ?";

        try {
            logger.info("Adatok: " + uploadPictureData.getLanguage() + ", " + uploadPictureData.getCollectionType());
            int collectionId = jdbcTemplate.queryForObject(selectSql,
                    new Object[]{uploadPictureData.getLanguage(), uploadPictureData.getCollectionType()},
                    Integer.class);

            logger.info("Kollekció azonosítójának lekérése sikeres: " + collectionId);

            return collectionId;
        } catch (DataAccessException e) {
            logger.warn("Nem sikerült lekérni a kollekció azonosítóját a megadott adatok alapján.", e);
            return -1;
        }
    }

    private int getAnswerIdByCriteria(UploadPictureData uploadPictureData) {
        final String selectSql = "SELECT answer_option.id " +
                "FROM answer_collection " +
                "JOIN answer_collection_wordlist ON answer_collection_wordlist.id = answer_collection.answer_collection_wordlist_id " +
                "JOIN answer_collection_wordlist_international ON answer_collection_wordlist_international.answer_collection_wordlist_id = answer_collection_wordlist.id " +
                "JOIN language ON language.id = answer_collection_wordlist_international.language_id " +
                "JOIN language_name ON language.id = language_name.language_id " +
                "JOIN answer_collection_answers ON answer_collection_answers.answer_collection_id = answer_collection.id " +
                "JOIN answer_option ON answer_option.id = answer_collection_answers.answer_option_id " +
                "JOIN picture_answer_type ON answer_option.picture_answer_type_id = picture_answer_type.id " +
                "JOIN type_wordlist ON type_wordlist.id = picture_answer_type.type_wordlist_id " +
                "JOIN type_wordlist_international ON type_wordlist.id = type_wordlist_international.wordlist_id AND language.id = type_wordlist_international.language_id " +
                "JOIN picture_answer_answer ON answer_option.picture_answer_answer_id = picture_answer_answer.id " +
                "JOIN answer_wordlist ON answer_wordlist.id = picture_answer_answer.answer_wordlist_id " +
                "JOIN answer_wordlist_international ON answer_wordlist_international.wordlist_id = answer_wordlist.id AND language.id = answer_wordlist_international.language_id " +
                "WHERE answer_collection.id = ? AND language_name.name = ? " +
                "AND type_wordlist_international.word = ? AND answer_wordlist_international.word = ? " +
                "LIMIT 1";

        int collection_id = uploadPictureData.getCollection_id();
        String language = uploadPictureData.getLanguage();
        String answerType = uploadPictureData.getPictureType();
        String answer = uploadPictureData.getPictureAnswer();
        logger.info("Adatok: " + collection_id + ", " + language + ", " + answerType + ", " + answer);
        try {
            Integer answerId = jdbcTemplate.queryForObject(selectSql,
                    //new Object[]{uploadPictureData.getCollection_id(), uploadPictureData.getLanguage(), uploadPictureData.getPictureType(), uploadPictureData.getPictureAnswer()},
                    new Object[]{collection_id, language, answerType, answer},
                    Integer.class);

            logger.info("Válasz azonosítójának lekérése sikeres: " + answerId);

            return answerId != null ? answerId : -1;
        } catch (DataAccessException e) {
            logger.warn("Nem sikerült lekérni a válasz azonosítóját a megadott kritériumok alapján." + e);
            return -1;
        }
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
    
    private boolean storePictureRealAnswer(int pictureId, int answerOptionId) 
    {
        try 
        {
            String insertSql = "INSERT INTO picture_real_answers (picture_id, answer_option_id) VALUES (?, ?)";
            int rowsAffected = jdbcTemplate.update(insertSql, pictureId, answerOptionId);

            if (rowsAffected > 0) 
            {
                logger.info("Sikeresen beszúrt sor a picture_real_answers táblába.");
                return true;
            } else 
            {
                logger.warn("Nem sikerült beszúrni a sort a picture_real_answers táblába.");
                return false;
            }
        } catch (DataAccessException e) 
        {
            logger.error("Hiba történt a beszúrás közben a picture_real_answers táblába.", e);
            return false;
        }
    }
  
    public int storePicture(UploadPictureData uploadPictureData)
    {
        TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition());
        
        int picture_id = insertNewPicture();
        if(picture_id == -1)
        {
            logger.warn("Kép beszúrása sikertelen, tranzakció visszavonása...");
            transactionManager.rollback(status);
            return -1;
        }
        
        uploadPictureData.setCollection_id(getCollectionIdByName(uploadPictureData));
        if(uploadPictureData.getCollection_id()==-1)
        {
            logger.warn("A kollekció nem létezik, tranzakció visszavonása...");
            transactionManager.rollback(status);
            return -1;
        }
        
        int answer_option_id=getAnswerIdByCriteria(uploadPictureData);
        if(answer_option_id==-1)
        {
            logger.warn("A kollekcióhoz nem létezik adott válasz...");
            transactionManager.rollback(status);
            return -1;
        }
        
        try
        {
            storeBinData(picture_id, uploadPictureData.getPictureBytes());
            logger.info("Kép fragmentjeinek beszúrása sikeres, picture_id : " + picture_id);
            
            storePictureRealOptions(picture_id, uploadPictureData.getCollection_id());
            logger.info("A picture_real_options táblába történő beszúrás sikeres, picture_id : " + picture_id);
            
            storePictureRealAnswer(picture_id,answer_option_id);
            logger.info("A picture_real_answers táblába történő beszúrás sikeres,\npicture_id és answer_option_id: (" + picture_id + ", " + answer_option_id + ")");
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
    
    public List<PictureData> getPictures(String collectionName, String language, int askedPictures) 
    {   
        logger.info("Lekérendő képek: " + collectionName + ", " + language + ", " + askedPictures);
        String whereClause;
        if (collectionName.equals("none") || true) 
        {
            String randomCollectionIdSql = "SELECT id FROM answer_collection ORDER BY RAND() LIMIT 1";

            int randomCollectionId = jdbcTemplate.queryForObject(randomCollectionIdSql, Integer.class);

            whereClause = "WHERE answer_collection.id = " + randomCollectionId +" AND language_name.name = " + "\"" + language + "\"";
        } else 
        {
            whereClause = "WHERE answer_collection_wordlist_international.word = " + "\"" + collectionName + "\"" + " AND language_name.name = " + "\"" + language + "\"";
        }
        
        logger.info("A where feltétel: " + whereClause);

        final String selectSql = "SELECT answer_collection.id AS collection_id, " +
                "answer_collection_wordlist_international.word AS collection_name, " +
                "language_name.name AS language, " +
                "answer_option.id AS answer_id, " +
                "type_wordlist_international.word AS type, " +
                "answer_wordlist_international.word AS name, " +
                "answer_collection_answers.nth_answer " +
                "FROM answer_collection " +
                "JOIN answer_collection_wordlist ON answer_collection_wordlist.id = answer_collection.answer_collection_wordlist_id " +
                "JOIN answer_collection_wordlist_international ON answer_collection_wordlist_international.answer_collection_wordlist_id = answer_collection_wordlist.id " +
                "JOIN language ON language.id = answer_collection_wordlist_international.language_id " +
                "JOIN language_name ON language.id = language_name.language_id AND language_name.language_id = language_name.name_language_id " +
                "JOIN answer_collection_answers ON answer_collection_answers.answer_collection_id = answer_collection.id " +
                "JOIN answer_option ON answer_option.id = answer_collection_answers.answer_option_id " +
                "JOIN picture_answer_type ON answer_option.picture_answer_type_id = picture_answer_type.id " +
                "JOIN type_wordlist ON type_wordlist.id = picture_answer_type.type_wordlist_id " +
                "JOIN type_wordlist_international ON type_wordlist.id = type_wordlist_international.wordlist_id AND language.id = type_wordlist_international.language_id " +
                "JOIN picture_answer_answer ON answer_option.picture_answer_answer_id = picture_answer_answer.id " +
                "JOIN answer_wordlist ON answer_wordlist.id = picture_answer_answer.answer_wordlist_id " +
                "JOIN answer_wordlist_international ON answer_wordlist_international.wordlist_id = answer_wordlist.id AND language.id = answer_wordlist_international.language_id " +
                whereClause + " " +
                "ORDER BY answer_collection.id, answer_collection_answers.nth_answer";

        List<CollectionData> collectionDataList = jdbcTemplate.query(
            selectSql,
            new RowMapper<CollectionData>() 
            {
                @Override
                public CollectionData mapRow(ResultSet rs, int rowNum) throws SQLException 
                {
                    int collectionId = rs.getInt("collection_id");
                    String collectionName = rs.getString("collection_name");
                    String language = rs.getString("language");
                    int answerId = rs.getInt("answer_id");
                    String type = rs.getString("type");
                    String name = rs.getString("name");
                    int nthAnswer = rs.getInt("nth_answer");

                    return new CollectionData(collectionId, collectionName, language, answerId, type, name, nthAnswer);
                }
            });

        int collectionId = collectionDataList.get(0).getCollectionId();
        String pictureSql = "SELECT picture_id FROM picture " +
                            "JOIN picture_real_options ON picture.id = picture_real_options.picture_id " +
                            "WHERE picture_real_options.answer_collection_id = " + collectionId + " " +
                            "ORDER BY RAND() LIMIT " + askedPictures;

        List<Integer> pictureIdList = jdbcTemplate.queryForList(pictureSql, Integer.class);

        if (askedPictures > pictureIdList.size()) 
        {
            logger.warn("A kért képek száma nagyobb (" + askedPictures + "), " + "mint amennyi rendelkezésre áll (" + pictureIdList.size() + "). Kérlek, ellenőrizd az inputot.");
            askedPictures = pictureIdList.size();
        }

        StringBuilder bindataSql = new StringBuilder("SELECT picture_id, bin_data FROM picture_bin_data WHERE picture_id IN (");
        for (int i = 0; i < askedPictures; i++) {
            bindataSql.append("?");
            if (i < askedPictures - 1) {
                bindataSql.append(", ");
            }
        }
        bindataSql.append(")");

        logger.warn("A kiválasztott képek: " + Arrays.toString(pictureIdList.toArray()));
        
        List<PictureData> result = jdbcTemplate.query(
            bindataSql.toString(),
            pictureIdList.toArray(),
            (rs, rowNum) -> {
                int pictureId = rs.getInt("picture_id");
                byte[] binData = rs.getBytes("bin_data");
                return new PictureData(pictureId, binData);
            }
        );

        if (result == null || result.isEmpty()) 
        {
            logger.warn("Nem sikerült képet szerezni az adatbázisból");
        } else 
        {
            logger.info("Sikerült képeket szerezni az adatbázisból");
        }

        for (int i = 0; i < result.size(); i++) 
        {
            logger.info("Iteration: " + i + ", Result size: " + result.size());
            AnswerOption[] ao = new AnswerOption[collectionDataList.size()];
            for (int j = 0; j < collectionDataList.size(); j++) 
            {
                ao[j] = new AnswerOption(collectionDataList.get(j).getAnswerId(), collectionDataList.get(j).getType(), collectionDataList.get(j).getName());
            }
            result.get(i).setAnswerOptions(ao);
            result.get(i).setPictureAnswerNickname(collectionDataList.get(0).getCollectionName());
        }
        return result;
    }

    
    public boolean uploadPictureAnswer(PictureAnswer pictureAnswer, int gameId) 
    {
        final String insertSql = "INSERT INTO player_game_answer (player_game_id, picture_id, answer_option_id) VALUES (?, ?, ?)";

        try 
        {
            jdbcTemplate.update(insertSql, gameId, pictureAnswer.getPictureId(), pictureAnswer.getAnswerId());
            logger.info("Képre adott válasz feltöltése sikeres, adatok: " + pictureAnswer);
            return true;
        } catch (DataAccessException e) 
        {
            logger.error("Képre adott válasz feltöltése sikertelen, adatok: " + pictureAnswer, e);
            return false;
        }
    }
}