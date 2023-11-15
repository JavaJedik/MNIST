import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles/styles.css"
import { content } from './contents/homeContent';
import { changer } from "./changer";
import AuthService from '../AuthService';

const Home = () => {
    const userToken = localStorage.getItem('userToken');
    const navigate = useNavigate();
    const [isDropdownOpen, setIsDropdownOpen] = useState(false);
    const [darkMode, setDarkMode] = useState(changer.darkMode);
    const [selectedLanguage, setSelectedLanguage] = useState(changer.language);

    const text = content[selectedLanguage];

    console.log(userToken)

    useEffect(() => {
        const fetchData = async () => {
            try {
                const data = await AuthService.checkLoggedIn();
                console.log(data)

                if (data !== 200 || data === null) {
                    throw new Error("Hiba a token ellenőrzésében!")
                }

            } catch (error) {
                console.error('Hiba az autentikációs ellenőrzésben:', error);
                alert(`Hiba az autentikációs ellenőrzésben: ${error}`);
                navigateLogin()
            }
        };

        fetchData();
    }, []);

    const navigateLogin = () => {
        localStorage.removeItem('userToken');
        changer.setChangerItems(selectedLanguage, darkMode);
        navigate("/login");
    };

    const navigateNumberGame = async () => {
        changer.setChangerItems(selectedLanguage, darkMode);
        const gameToken = await AuthService.askGameToken(localStorage.getItem("userToken"));
        console.log("success: " + gameToken.success);
        if(gameToken.success) {
            console.log("gameToken success volt");
            navigate("/number_game");
        } else {
            navigate("/login");
        }
    };

    const navigatePictureGame = async () => {
        changer.setChangerItems(selectedLanguage, darkMode);
        const gameToken = await AuthService.askGameToken(localStorage.getItem("userToken"));
        console.log("success: " + gameToken.success);
        if(gameToken.success) {
            console.log("gameToken success volt");
            navigate("/picture_game");
        } else {
            navigate("/login");
        }
    };

    const handleDropdownItemClick = (language) => {
        setSelectedLanguage(language);
        setIsDropdownOpen(false);
    };

    const navigateLeaderboard = () => {
        changer.setChangerItems(selectedLanguage, darkMode);
        navigate("/leaderboard");
    }

    /*const navigateLeaderboard = async () => {
        changer.setChangerItems(selectedLanguage, darkMode);
        try {
            const data = await AuthService.checkUserToken();

            if (data.success) {
                navigate('/leaderboard');
                console.log('Ranglista megnyitása.');
            } else {
                console.log('Ranglista megnyitása sikertelen.');
                throw new Error('Ranglista megnyitása sikertelen.');
            }
        } catch (error) {
            console.error('Ranglista megnyitása sikertelen:', error);
            navigateLogin()
        }
    };*/

    return (
        <div div className={`main-container ${darkMode ? "dark-main-container" : ""}`}>

            <label className="switch">
                <input
                    defaultChecked={false}
                    type="checkbox"
                    checked={darkMode}
                    onChange={() => setDarkMode(!darkMode)}
                />
                <span className={`slider round ${darkMode ? "dark-slider" : ""}`} />
            </label>

            <div className={`classname ${darkMode ? "dark" : ""}`} />

            <div className={`home-blur-container ${darkMode ? "dark-blur-container" : ""}`} />
                <div className="home-container">
                    <div>
                        <h1 className={`home-header ${darkMode ? "dark-content-bottom" : ""}`}>
                            {text.welcome}
                        </h1>
                    </div>
                    <div
                        className={`home-dropdown ${isDropdownOpen ? "active" : ""}`}>
                        <button
                            className={`home-dropbtn ${darkMode ? "dark-button-style" : ""}`}
                            onClick={() => setIsDropdownOpen(!isDropdownOpen)}>
                            <span className={`${darkMode ? "dark-span" : ""}`}>
                                {text.language}
                            </span>
                            <span className="dropbtn-arrow">
                                &#9660;
                            </span>
                        </button>
                        <div id="home-myDropdown">
                            <div className={`home-dropdown-content ${darkMode ? "dark-dropdown-content" : ""}`}>
                                <p onClick={() => handleDropdownItemClick("HUN")}>
                                    Magyar
                                </p>
                                <p onClick={() => handleDropdownItemClick("ENG")}>
                                    English
                                </p>
                            </div>
                        </div>
                    </div>
                    <div>
                        <button
                            className={`home-button-style ${darkMode ? "dark-button-style" : ""}`}
                            onClick={navigateLeaderboard}>
                            {text.leaderboard}
                        </button>
                    </div>
                    <div>
                        <button
                            className={`home-button-style ${darkMode ? "dark-button-style" : ""}`}
                            onClick={navigateNumberGame}>
                            <u>
                                {text.game}
                            </u>
                        </button>
                    </div>
                    <div>
                        <button
                            className={`home-button-style ${darkMode ? "dark-button-style" : ""}`}
                            onClick={navigatePictureGame}>
                            <u>
                                {text.picture_game}
                            </u>
                        </button>
                    </div>
                    <div className="home-content">
                        <button
                            className={`home-button-style ${darkMode ? "dark-button-style" : ""}`}
                            onClick={navigateLogin}>
                            {text.logout}
                        </button>
                    </div>
                </div>

        </div>
    );
};

export default Home;