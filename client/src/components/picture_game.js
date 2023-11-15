import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles/styles.css"
import { content } from "./contents/picture_gameContent";
import { changer } from "./changer";

const Number_Game = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const navigate = useNavigate();
    const [numAnswers, setNumAnswers] = useState(3);
    const maxNumber = 30;

    const imagePath = "./placeholder.png"

    const [darkMode, setDarkMode] = useState(changer.darkMode);
    const [selectedLanguage, setSelectedLanguage] = useState(changer.language);

    const text = content[selectedLanguage];

    const setLocalStorageItems = () => {
        localStorage.setItem("language", selectedLanguage);
        localStorage.setItem("darkMode", JSON.stringify(darkMode));
    }

    const navigateHome = () => {
        setLocalStorageItems();
        navigate('/home');
    };

    const navigateLeaderboard = () => {
        setLocalStorageItems();
        navigate('/leaderboard');
    };

    const handleClick = (clickedNumber) => {
        alert("A válaszod: " + clickedNumber);
    }

    const handleSliderChange = (event) => {
        if(event.target.value <= maxNumber) {
            setNumAnswers(parseInt(event.target.value, 10));
        }
    };


    return (
        <div className={`main-container ${darkMode ? "dark-main-container" : ""}`}>
            <div className="game-main-container">

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

                <div className="game-left-container">
                    <img className="image" src={require(`${imagePath}`)} alt="A kép betöltése sikertelen." />

                    <div className={`slider-container ${darkMode ? "dark-blur-container" : ""}`}>
                        <div className={`slider-text ${darkMode ? "dark-text" : ""}`}>
                            {text.numberofanswers}
                        </div>
                        <input
                            className={`answer-slider ${darkMode ? "dark-answer-slider" : ""}`}
                            type="range"
                            min="2"
                            max="30"
                            value={numAnswers}
                            onChange={handleSliderChange}
                        />
                        <input
                            className={`answer-number-input ${darkMode ? "dark-answer-number-input" : ""}`}
                            type="number"
                            value={numAnswers}
                            onChange={handleSliderChange}
                        />
                    </div>

                </div>
                <div className="game-right-container">
                    <div className={`game-blur-container ${darkMode ? "dark-blur-container" : ""}`}/>
                    <div className="game-container">
                        <div className="content">
                            <div className={`picture-numbers ${darkMode ? "dark-numbers" : ""}`}>
                                {Array.from({ length: numAnswers }).map((_, index) => (
                                    <div
                                        className="picture-number"
                                        onClick={() => handleClick(index+1)}
                                    >
                                        <button
                                            key={index}
                                            className={`number-button ${darkMode ? "dark-number-button" : ""}`}

                                        >
                                            {`Btn ${index + 1}`}
                                        </button>
                                    </div>
                                ))}
                            </div>
                            <button
                                className={`button-style left-game-button ${darkMode ? "dark-button-style" : ""}`}
                                onClick={navigateHome}
                            >
                                {text.goback}
                            </button>
                            <button
                                className={`button-style right-game-button ${darkMode ? "dark-button-style" : ""}`}
                                onClick={navigateLeaderboard}
                            >
                                {text.leaderboard}
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Number_Game;