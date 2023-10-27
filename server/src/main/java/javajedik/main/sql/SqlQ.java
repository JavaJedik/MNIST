/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package javajedik.main.sql;

/**
 *
 * @author admin1
 */
public class SqlQ 
{
    public static final String getAllRegisteredPlayers()
    {
        return "select * from registered_player";
    }
    
    public static final String insertRegisteredPlayerMinimal()
    {
        return "insert into registered_player (player_id, name, gender_id, email_prefix, email_type_id) values (?, ?, ?, ?, ?)";
    }
    
    public static final String insertPlayerId()
    {
        return "insert into player_id (main_language_id, player_role_id) values (?, ?)";
    }
    
    public static final String getLanguageIdByName()
    {
        return  "select language.id " +
                "from language " +
                "inner join language_name ON language_name.language_id = language.id " +
                "where language_name.name = ? " +
                "limit 1";
    }
    
    public static final String getGenderIdByName()
    {
        return  "select gender.id " +
                "from gender " +
                "inner join gender_name on gender.id = gender_name.gender_id " +
                "where gender_name.name = ? " +
                "limit 1";
    }
    
    public static final String getEmailTypeIdFromDatabase()
    {
        return  "select email_type.id " +
                "from email_tld " +
                "join email_type ON email_type.tld_id = email_tld.id " +
                "where email_type.domain = ? " +
                "and email_tld.tld = ?";
    }
    
    public static final String getPasswordEntry()
    {
        return "select salt, password_hash, created_at from password where player_id = ? order by created_at desc limit 1";
    }
    
    public static final String storePassword()
    {
        return "insert into password (player_id, salt, password_hash) values (?, ?, ?)";
    }
    
    public static final String getPlayerIdByName()
    {
        return "select player_id from registered_player where name = ? limit 1";
    }
}
