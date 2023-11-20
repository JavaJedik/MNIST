import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles/styles.css"
import { content } from "./contents/number_gameContent";
import { changer } from "./changer";
import AuthService from "../AuthService";

const Number_Game = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const navigate = useNavigate();
    
    const [pictures, setPictures] = useState([]);
    const [currentPictureIndex, setCurrentPictureIndex] = useState(0);
    const [imageUrl, setImageUrl] = useState('');

    const [darkMode, setDarkMode] = useState(changer.darkMode);
    const [selectedLanguage, setSelectedLanguage] = useState(changer.language);

    const text = content[selectedLanguage];

    //AuthService.askNumberPicture(localStorage.getItem("gameToken"));

    /*useEffect(() => {
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
    }, []);*/

    const renderCurrentPicture = () => {
        console.log("A képek száma: ", pictures.length)
        if (
            pictures.length > 0 &&
            currentPictureIndex >= 0 &&
            currentPictureIndex < pictures.length
        ) {
            const currentPicture = pictures[currentPictureIndex];
            const base64ImageData = currentPicture.pictureBytes;
            const byteCharacters = atob(base64ImageData);
            const byteNumbers = new Array(byteCharacters.length);
            for (let i = 0; i < byteCharacters.length; i++) {
                byteNumbers[i] = byteCharacters.charCodeAt(i);
            }
            const byteArray = new Uint8Array(byteNumbers);
            const blob = new Blob([byteArray], { type: "image/png" });
            setImageUrl(URL.createObjectURL(blob)); // Itt állítsd be az imageUrl-t
        } else {
            return <div>Nincs kép vagy betöltés...</div>;
        }
    };
    
useEffect(() => {
    document.addEventListener('keydown', handleKeyPress);
    
    const fetchData = async () => {
        try {
            const response = await AuthService.askNumberPicture(localStorage.getItem("gameToken"), 5);
            if (response.success) {
                console.log("A gamere érkezett adatok: ", response.response)
                setPictures(response.response); // Az összes képet beállítjuk
                setCurrentPictureIndex(0); // Az első képet állítjuk be kezdetben
                renderCurrentPicture();
            } else {
                //navigateLogin();
            }
        } catch (error) {
            console.error("Képek lekérése sikertelen", error);
        }
    };

    fetchData();

    return () => {
        document.removeEventListener('keydown', handleKeyPress);
    };
}, [pictures.length==0]);

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
        changer.setChangerItems(selectedLanguage, darkMode);
        navigate('/home');
    };
    
    const navigateLogin = () => {
        changer.setChangerItems(selectedLanguage, darkMode);
        localStorage.removeItem("userToken");
        navigate('/login');
    };

    const navigateLeaderboard = () => {
        changer.setChangerItems(selectedLanguage, darkMode);
        navigate('/leaderboard');
    };

    const handleClick = (clickedNumber) => {
        alert("A válaszod: " + clickedNumber);
       if (pictures.length === 1) {
            // Ha csak egy elem van a tömbben, akkor törölje az összes elemét
            setPictures([]);
        } else if (pictures.length > 1) {
            // Ha több, mint egy elem van a tömbben, törölje az első elemet
            const updatedPictures = pictures.slice(1);
            setPictures(updatedPictures);
            setCurrentPictureIndex(0);
            renderCurrentPicture();
        }
    }

    return (
        <div className={`main-container ${darkMode ? "dark-main-container" : ""}`}>
            <div className="game-main-container">

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

                <div className="game-left-container">
                    <img className="image" src={imageUrl} alt="A kép betöltése sikertelen." />
                </div>

                <div className="game-right-container">
                    <div className={`game-blur-container ${darkMode ? "dark-blur-container" : ""}`}/>
                    <div className="game-container">
                        <div className="content">

                            <div className={`numbers ${darkMode ? "dark-numbers" : ""}`}>
                                <div className={`numbers-top ${darkMode ? "dark-numbers-top" : ""}`}>
                                    <div className="numbers-top-text">
                                        {text.toptext}
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
                                        {text.idk}
                                    </button>
                                </div>
                            </div>
                            <div className="button-container">
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
        </div>
    );
};

export default Number_Game;