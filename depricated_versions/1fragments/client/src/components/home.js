import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles.css"
import { content } from './contents/homeContent';
import { changer } from "./changer";
import AuthService from '../AuthService';

const Home = () => {
    //const token = localStorage.getItem('userToken');
    const navigate = useNavigate();
    const [isDropdownOpen, setIsDropdownOpen] = useState(false);
    const [darkMode, setDarkMode] = useState(changer.darkMode);
    const [selectedLanguage, setSelectedLanguage] = useState(changer.language);

    const text = content[selectedLanguage];

    /*useEffect(() => {
        const fetchData = async () => {
            try {
                const data = await AuthService.checkLoggedIn();

                if (!data.success) {
                    navigateLogin();
                }
            } catch (error) {
                console.error('Hiba az autentikációs ellenőrzésben:', error);
            }
        };

        fetchData();
    }, []);*/

    const navigateLogin = () => {
        //localStorage.removeItem('userToken');
        changer.setChangerItems(selectedLanguage, darkMode);
        navigate("/login");
    };

    const navigateNumberGame = () => {
        changer.setChangerItems(selectedLanguage, darkMode);
        navigate("/number_game");
    };

    /*const navigateQuiz = async () => {
        try {
            const data = await AuthService.checkLoggedIn();

            if (data.success) {
                navigate("/quiz");
            } else {
                navigateLogin();
            }
        } catch (error) {
            console.error('Hiba az autentikációs ellenőrzésben:', error);
        }
    };

    const navigateLeaderboard = async () => {
        try {
            const data = await AuthService.checkLoggedIn();

            if (data.success) {
                navigate("/leaderboard");
            } else {
                navigateLogin();
            }
        } catch (error) {
            console.error('Hiba az autentikációs ellenőrzésben:', error);
        }
    };*/

    const handleDropdownItemClick = (language) => {
        setSelectedLanguage(language);
        setIsDropdownOpen(false);
    };

    const navigateLeaderboard = async () => {
        changer.setChangerItems(selectedLanguage, darkMode);
        try {
            const data = await AuthService.checkUserToken();

            if (data.success) {
                navigate('/leaderboard');
                console.log('Ranglista megnyitása.');
            } else {
                alert('Ranglista megnyitása sikertelen.');
                console.log('Ranglista megnyitása sikertelen.');
                navigate('/login');
            }
        } catch (error) {
            console.error('Ranglista megnyitása sikertelen:', error);
            navigate('/login');
        }
    };

    return (
        <div className="main-container">

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