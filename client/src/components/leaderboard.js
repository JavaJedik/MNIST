import React, {useEffect, useState} from 'react';
import { useNavigate } from 'react-router-dom';
import { content } from './contents/leaderboardContent';
import "./styles/styles.css"
import {changer} from "./changer";
import AuthService from "../AuthService";

const Leaderboard = () => {
    const navigate = useNavigate();

    const [darkMode, setDarkMode] = useState(changer.darkMode);
    const [selectedLanguage, setSelectedLanguage] = useState(changer.language);

    const text = content[selectedLanguage];

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

    const navigateHome = () => {
        changer.setChangerItems(selectedLanguage, darkMode);
        navigate('/home');
    };

    const name = "sample name";
    const winnings = "sample prize";
    const goodAnswers = "sample number";
    const sumOfWinnings = "sample sum";

    return (
        <div className={`main-container ${darkMode ? "dark-main-container" : ""}`}>

            <label className="switch">
                <input
                    defaultChecked={false}
                    type="checkbox"
                    checked={darkMode}
                    onChange={() => setDarkMode(prevState => !prevState)}
                />
                <span className={`slider round ${darkMode ? "dark-slider" : ""}`} />
            </label>

            <div className={`classname ${darkMode ? "dark" : ""}`} />

            <div className={`board-blur-container ${darkMode ? "dark-blur-container" : ""}`} />
            <div className="board-container">
                <table className={`${darkMode ? "dark-table" : ""}`}>
                    <thead className="thead-style">
                        <tr>
                            <td>{text.placement}</td>
                            <td>{text.name}</td>
                            <td>{text.prize}</td>
                            <td>{text.goodanswers}</td>
                            <td>{text.summedprizes}</td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1.</td>
                            <td>{name}</td>
                            <td>{winnings}</td>
                            <td>{goodAnswers}</td>
                            <td>{sumOfWinnings}</td>
                        </tr>
                        <tr>
                            <td>2.</td>
                            <td>{name}</td>
                            <td>{winnings}</td>
                            <td>{goodAnswers}</td>
                            <td>{sumOfWinnings}</td>
                        </tr>
                        <tr>
                            <td>3.</td>
                            <td>{name}</td>
                            <td>{winnings}</td>
                            <td>{goodAnswers}</td>
                            <td>{sumOfWinnings}</td>
                        </tr>
                        <tr>
                            <td>4.</td>
                            <td>{name}</td>
                            <td>{winnings}</td>
                            <td>{goodAnswers}</td>
                            <td>{sumOfWinnings}</td>
                        </tr>
                        <tr>
                            <td>5.</td>
                            <td>{name}</td>
                            <td>{winnings}</td>
                            <td>{goodAnswers}</td>
                            <td>{sumOfWinnings}</td>
                        </tr>
                        <tr>
                            <td>6.</td>
                            <td>{name}</td>
                            <td>{winnings}</td>
                            <td>{goodAnswers}</td>
                            <td>{sumOfWinnings}</td>
                        </tr>
                        <tr>
                            <td>7.</td>
                            <td>{name}</td>
                            <td>{winnings}</td>
                            <td>{goodAnswers}</td>
                            <td>{sumOfWinnings}</td>
                        </tr>
                        <tr>
                            <td>8.</td>
                            <td>{name}</td>
                            <td>{winnings}</td>
                            <td>{goodAnswers}</td>
                            <td>{sumOfWinnings}</td>
                        </tr>
                        <tr>
                            <td>9.</td>
                            <td>{name}</td>
                            <td>{winnings}</td>
                            <td>{goodAnswers}</td>
                            <td>{sumOfWinnings}</td>
                        </tr>
                        <tr className="bottom-cell">
                            <td>10.</td>
                            <td>{name}</td>
                            <td>{winnings}</td>
                            <td>{goodAnswers}</td>
                            <td>{sumOfWinnings}</td>
                        </tr>
                    </tbody>
                </table>
                <button
                    className="home-button-style"
                    className={`home-button-style ${darkMode ? "dark-button-style" : ""}`}
                    onClick={navigateHome}
                >
                    {text.backbutton}
                </button>
            </div>
        </div>
    )
};

//Név, legmagasabbszint, legtöbb elvitt pénz, elvitt összes pénz, játékok száma, jól megválaszolt nehezebb kérdések száma

export default Leaderboard;