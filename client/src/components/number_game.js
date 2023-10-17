import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles.css"

const Number_Game = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const navigate = useNavigate();

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
                <div className="game-left-container">
                    <div className="image">
                    </div>
                </div>
                <div className="game-right-container">
                    <div className="game-blur-container"/>
                    <div className="game-container">
                        <div className="content">
                            <div className="numbers">
                                <div className="numbers-top">
                                    <div className="numbers-top-text">
                                        Adjon meg egy választ!
                                    </div>
                                </div>
                                <div className="number" onClick={() => handleClick(1)}>
                                    <button className="number-button">
                                        1
                                    </button>
                                </div>
                                <div className="number" onClick={() => handleClick(2)}>
                                    <button className="number-button">
                                        2
                                    </button>
                                </div>
                                <div className="number" onClick={() => handleClick(3)}>
                                    <button className="number-button">
                                        3
                                    </button>
                                </div>
                                <div className="number" onClick={() => handleClick(4)}>
                                    <button className="number-button">
                                        4
                                    </button>
                                </div>
                                <div className="number" onClick={() => handleClick(5)}>
                                    <button className="number-button">
                                        5
                                    </button>
                                </div>
                                <div className="number" onClick={() => handleClick(6)}>
                                    <button className="number-button">
                                        6
                                    </button>
                                </div>
                                <div className="number" onClick={() => handleClick(7)}>
                                    <button className="number-button">
                                        7
                                    </button>
                                </div>
                                <div className="number" onClick={() => handleClick(8)}>
                                    <button className="number-button">
                                        8
                                    </button>
                                </div>
                                <div className="number" onClick={() => handleClick(9)}>
                                    <button className="number-button">
                                        9
                                    </button>
                                </div>
                                <div className="number"  onClick={() => handleClick(1)}>
                                    <button className="number-button">
                                        0
                                    </button>
                                </div>
                                <div className="idk">
                                    <button className="idk-button" onClick={() => handleClick("Nem tudom")}>
                                        Nem tudom
                                    </button>
                                </div>
                            </div>
                            <button className="button-style" onClick={navigateHome}>
                                Visszalépés
                            </button>
                            <button className="button-style right-button" onClick={navigateLeaderboard}>
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