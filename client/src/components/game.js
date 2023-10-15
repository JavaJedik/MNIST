import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles.css"

const Game = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const navigate = useNavigate();

    const navigateHome = () => {
        navigate('/home');
    };

    const navigateLeaderboard = () => {
        navigate('/leaderboard');
    };

    return (
        <div className="main-container">

            <div className="image">
            </div>

            <div className="game-blur-container"/>
            <div className="game-container">
                <div className="content">

                    <div className="numbers">
                        <div className="numbers-top">
                            <div className="numbers-top-text">
                                Adjon meg egy választ!
                            </div>
                        </div>
                        <div className="number">
                            <button className="number-button">
                                1
                            </button>
                        </div>
                        <div className="number">
                            <button className="number-button">
                                2
                            </button>
                        </div>
                        <div className="number">
                            <button className="number-button">
                                3
                            </button>
                        </div>
                        <div className="number">
                            <button className="number-button">
                                4
                            </button>
                        </div>
                        <div className="number">
                            <button className="number-button">
                                5
                            </button>
                        </div>
                        <div className="number">
                            <button className="number-button">
                                6
                            </button>
                        </div>
                        <div className="number">
                            <button className="number-button">
                                7
                            </button>
                        </div>
                        <div className="number">
                            <button className="number-button">
                                8
                            </button>
                        </div>
                        <div className="number">
                            <button className="number-button">
                                9
                            </button>
                        </div>
                        <div className="number">
                            <button className="number-button">
                                0
                            </button>
                        </div>
                        <div className="idk">
                            <div className="idk-text">
                                Nem tudom
                            </div>
                        </div>
                    </div>

                    <button className="button-style" onClick={navigateHome}>
                        Kilépés
                    </button>
                    <button className="button-style" onClick={navigateLeaderboard}>
                        Toplista
                    </button>
                </div>
            </div>
        </div>
    );
};

export default Game;