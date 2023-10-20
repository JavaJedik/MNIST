package javajedik.main.sql;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;
import javajedik.main.model.RegisteredPlayer;

@Repository
public class RegistratePlayerSQL {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<RegisteredPlayer> getAllRegisteredPlayers() 
    {
        String sql = "SELECT * FROM registered_player";

        List<RegisteredPlayer> players = jdbcTemplate.query(sql, (rs, rowNum) -> 
        {
            RegisteredPlayer player = new RegisteredPlayer();
            player.setPlayerId(rs.getInt("player_id"));
            player.setName(rs.getString("name"));
            player.setGenderId(rs.getInt("gender_id"));
            player.setEmailPrefix(rs.getString("email_prefix"));
            player.setEmailTypeId(rs.getInt("email_type_id"));
            player.setCountryCallingCodeId(rs.getInt("country_calling_code_id"));
            player.setPhoneNetworkId(rs.getInt("phone_network_id"));
            player.setPhone(rs.getInt("phone"));
            return player;
        });

        return players;
    }
}

