import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles.css"

const Number_Game = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const navigate = useNavigate();
    const [darkMode, setDarkMode] = useState(false);
    const [numAnswers, setNumAnswers] = useState(3);

    const navigateHome = () => {
        navigate('/home');
    };

    const navigateLeaderboard = () => {
        navigate('/leaderboard');
    };

    const handleClick = (clickedNumber) => {
        alert("A válaszod: " + clickedNumber);
    }

    const handleSliderChange = (event) => {
        setNumAnswers(parseInt(event.target.value, 10));
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

            <div className="game-main-container">



                <div className="game-left-container">
                    <div className="image" />

                    <div className="slider-container">
                        <div className="slider-text">
                            Válaszok száma:
                        </div>
                        <input
                            className="answer-slider"
                            type="range"
                            min="2"
                            max="30"
                            value={numAnswers}
                            onChange={handleSliderChange}
                        />
                    </div>

                </div>
                <div className="game-right-container">
                    <div className="game-blur-container"/>
                    <div className="game-container">
                        <div className="content">
                            <div className="picture-numbers">
                                {Array.from({ length: numAnswers }).map((_, index) => (
                                    <div className="picture-number">
                                        <button key={index} className="number-button">{`Btn ${index + 1}`}</button>
                                    </div>
                                ))}
                            </div>
                            <button className="button-style left-game-button" onClick={navigateHome}>
                                Visszalépés
                            </button>
                            <button className="button-style right-game-button" onClick={navigateLeaderboard}>
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