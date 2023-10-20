import React, {useState} from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles.css"

const Leaderboard = () => {
    const navigate = useNavigate();
    const [darkMode, setDarkMode] = useState(false);

    const navigateHome = () => {
        navigate('/home');
    };

    const name = "sample name";
    const winnings = "sample prize";
    const goodAnswers = "sample number";
    const sumOfWinnings = "sample sum";

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

            <div className={`board-blur-container ${darkMode ? "dark-blur-container" : ""}`} />
            <div className="board-container">
                <table className={`${darkMode ? "dark-table" : ""}`}>
                    <thead className="thead-style">
                        <tr>
                            <td>Helyezés</td>
                            <td>Név</td>
                            <td>Nyeremény</td>
                            <td>Helyes válaszok (db)</td>
                            <td>Eddigi nyeremények összege</td>
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
                    Visszalépés
                </button>
            </div>
        </div>
    )
};

//Név, legmagasabbszint, legtöbb elvitt pénz, elvitt összes pénz, játékok száma, jól megválaszolt nehezebb kérdések száma

export default Leaderboard;