import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles.css"
//import AuthService from '../AuthService';

const Home = () => {
    //const token = localStorage.getItem('userToken');
    const navigate = useNavigate();
    const [selectedItem, setSelectedItem] = useState(null);
    const [isDropdownOpen, setIsDropdownOpen] = useState(false);

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
        navigate("/login");
    };

    const navigateNumberGame = () => {
        navigate("/number_game")
    }

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

    const handleDropdownItemClick = (item) => {
        setSelectedItem(item);
        setIsDropdownOpen(false)
    };

    const navigateLeaderboardTemp = () => {
        navigate("/leaderboard");
    }

    return (
        <div className="main-container">
            <div className="home-blur-container">
                <div className="home-container">
                    <div>
                        <h1 className="home-header">Üdvözöljük, Felhasználónév!</h1>
                    </div>
                    <div className={`home-dropdown ${isDropdownOpen ? "active" : ""}`}>
                        <button className="home-dropbtn" onClick={() => setIsDropdownOpen(!isDropdownOpen)}>
                            <span>
                                {selectedItem || "Válasszon nyelvet"}
                            </span>
                            <span className="dropbtn-arrow">
                                &#9660;
                            </span>
                        </button>
                        <div id="home-myDropdown">
                            <div className="home-dropdown-content">
                                <p onClick={() => handleDropdownItemClick("Magyar")}>Magyar</p>
                                <p onClick={() => handleDropdownItemClick("English")}>English</p>
                            </div>
                        </div>
                    </div>
                    <div>
                        <button className="home-button-style" onClick={navigateLeaderboardTemp}>
                            Toplista megtekintése
                        </button>
                    </div>
                    <div>
                        <button className="home-button-style" onClick={navigateNumberGame}>
                            <u>Játék indítása</u>
                        </button>
                    </div>
                    <div className="home-content">
                        <button className="home-button-style" onClick={navigateLogin}>
                            Kijelentkezés
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Home;