import React, {useEffect, useState} from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles.css"

const Number_Game = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const navigate = useNavigate();
    const [darkMode, setDarkMode] = useState(false);

    useEffect(() => {
        document.addEventListener('keydown', handleKeyPress);

        return () => {
            document.removeEventListener('keydown', handleKeyPress);
        };
    }, []);

    const handleKeyPress = (event) => {
        switch (event.key) {
            case '1':
                simulateButtonClick(event.key);
                break;
            case '2':
                simulateButtonClick(event.key);
                break;
            case '3':
                simulateButtonClick(event.key);
                break;
            case '4':
                simulateButtonClick(event.key);
                break;
            case '5':
                simulateButtonClick(event.key);
                break;
            case '6':
                simulateButtonClick(event.key);
                break;
            case '7':
                simulateButtonClick(event.key);
                break;
            case '8':
                simulateButtonClick(event.key);
                break;
            case '9':
                simulateButtonClick(event.key);
                break;
            case '0':
                simulateButtonClick(event.key);
                break;
            case 'Enter':
                simulateButtonClick(event.key);
                break;
        }
    };

    const simulateButtonClick = (number) => {
        const buttonId = `button${number}`;
        const button = document.getElementById(buttonId);
        if (button) {
            button.click();
        }
    };

    const navigateHome = () => {
        navigate('/home');
    };

    const navigateLeaderboard = () => {
        navigate('/leaderboard');
    };

    const handleClick = (clickedNumber) => {
        alert("A válaszod: " + clickedNumber);
    }

    return (
        <div className="main-container">
            <div className="game-main-container">

                <label className="switch">
                    <input
                        defaultChecked={false}
                        type="checkbox"
                        checked={darkMode}
                        onChange={() => setDarkMode(!darkMode)}
                    />
                    <span className="slider round"></span>
                </label>

                <div className={`classname ${darkMode ? "dark" : ""}`} />

                <div className="game-left-container">
                    <div className="image">
                    </div>
                </div>
                <div className="game-right-container">
                    <div className={`game-blur-container ${darkMode ? "dark-blur-container" : ""}`}/>
                    <div className="game-container">
                        <div className="content">

                            <div className={`numbers ${darkMode ? "dark-numbers" : ""}`}>
                                <div className={`numbers-top ${darkMode ? "dark-numbers-top" : ""}`}>
                                    <div className="numbers-top-text">
                                        Adjon meg egy választ!
                                    </div>
                                </div>
                                <div className="number" onClick={() => handleClick(1)}>
                                    <button
                                        id="button1"
                                        className={`number-button ${darkMode ? "dark-number-button" : ""}`}
                                    >
                                        1
                                    </button>
                                </div>
                                <div className="number" onClick={() => handleClick(2)}>
                                    <button
                                        id="button2"
                                        className={`number-button ${darkMode ? "dark-number-button" : ""}`}
                                    >
                                        2
                                    </button>
                                </div>
                                <div className="number" onClick={() => handleClick(3)}>
                                    <button
                                        id="button3"
                                        className={`number-button ${darkMode ? "dark-number-button" : ""}`}
                                    >
                                        3
                                    </button>
                                </div>
                                <div className="number" onClick={() => handleClick(4)}>
                                    <button
                                        id="button4"
                                        className={`number-button ${darkMode ? "dark-number-button" : ""}`}
                                    >
                                        4
                                    </button>
                                </div>
                                <div className="number" onClick={() => handleClick(5)}>
                                    <button
                                        id="button5"
                                        className={`number-button ${darkMode ? "dark-number-button" : ""}`}
                                    >
                                        5
                                    </button>
                                </div>
                                <div className="number" onClick={() => handleClick(6)}>
                                    <button
                                        id="button6"
                                        className={`number-button ${darkMode ? "dark-number-button" : ""}`}
                                    >
                                        6
                                    </button>
                                </div>
                                <div className="number" onClick={() => handleClick(7)}>
                                    <button
                                        id="button7"
                                        className={`number-button ${darkMode ? "dark-number-button" : ""}`}
                                    >
                                        7
                                    </button>
                                </div>
                                <div className="number" onClick={() => handleClick(8)}>
                                    <button
                                        id="button8"
                                        className={`number-button ${darkMode ? "dark-number-button" : ""}`}
                                    >
                                        8
                                    </button>
                                </div>
                                <div className="number" onClick={() => handleClick(9)}>
                                    <button
                                        id="button9"
                                        className={`number-button ${darkMode ? "dark-number-button" : ""}`}
                                    >
                                        9
                                    </button>
                                </div>
                                <div className="number last-number"  onClick={() => handleClick(0)}>
                                    <button
                                        id="button0"
                                        className={`number-button ${darkMode ? "dark-number-button" : ""}`}
                                    >
                                        0
                                    </button>
                                </div>
                                <div className="idk">
                                    <button
                                        id="number"
                                        className={`idk-button ${darkMode ? "dark-number-button" : ""}`}
                                        onClick={() => handleClick("Nem tudom")}>
                                        Nem tudom
                                    </button>
                                </div>
                            </div>
                            <button
                                className={`button-style left-game-button ${darkMode ? "dark-button-style" : ""}`}
                                onClick={navigateHome}
                            >
                                Visszalépés
                            </button>
                            <button
                                className={`button-style right-game-button ${darkMode ? "dark-button-style" : ""}`}
                                onClick={navigateLeaderboard}
                            >
                                Toplista
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Number_Game;