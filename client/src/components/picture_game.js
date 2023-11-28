import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles/styles.css"
import { content } from "./contents/picture_gameContent";
import { changer } from "./changer";
import AuthService from '../AuthService';

const Picture_Game = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const navigate = useNavigate();
    const [numAnswers, setNumAnswers] = useState(3);
    const maxNumber = 10;

    const [pictures, setPictures] = useState([]);
    const [numberOfAnswers, setNumberOfAnswers] = useState([]);
    const [currentPictureIndex, setCurrentPictureIndex] = useState(0);
    const [imageUrl, setImageUrl] = useState('');

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

    /*const setLocalStorageItems = () => {
        localStorage.setItem("language", selectedLanguage);
        localStorage.setItem("darkMode", JSON.stringify(darkMode));
    }*/

    const navigateHome = () => {
        // setLocalStorageItems();
        changer.setChangerItems(selectedLanguage, darkMode);
        navigate('/home');
    };

    const navigateLeaderboard = () => {
        // setLocalStorageItems();
        changer.setChangerItems(selectedLanguage, darkMode);
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

    useEffect(() => {
        //document.addEventListener('keydown', handleKeyPress);

        const fetchData = async () => {
            try {
                const response = await AuthService.askPicture(localStorage.getItem("gameToken"), 5);
                if (response.success) {
                    console.log("A gamere érkezett adatok: ", response.response)
                    setPictures(response.response); // Az összes képet beállítjuk
                    console.log("Response: ", response.response)
                    let answerOpt = response.response.answerOptions
                    setNumberOfAnswers(answerOpt)
                    console.log("Number of answers: ", numberOfAnswers)
                    setCurrentPictureIndex(0); // Az első képet állítjuk be kezdetben
                    renderCurrentPicture();
                } else {
                    navigateLogin();
                }
            } catch (error) {
                console.error("Képek lekérése sikertelen", error);
            }
        };

        fetchData();

        /*return () => {
            document.removeEventListener('keydown', handleKeyPress);
        };*/
    }, [pictures.length === 0]);

    const renderCurrentPicture = () => {
        console.log("A képek száma: ", pictures.length)
        if (
            pictures.length > 0 &&
            currentPictureIndex >= 0 &&
            currentPictureIndex < pictures.length
        ) {
            const currentPicture = pictures[currentPictureIndex];
            const base64ImageData = currentPicture.pictureBytes;
            console.log("A BASE64 kódolt kép: " + base64ImageData);
            const byteCharacters = atob(base64ImageData);
            const byteNumbers = new Array(byteCharacters.length);
            for (let i = 0; i < byteCharacters.length; i++) {
                byteNumbers[i] = byteCharacters.charCodeAt(i);
            }
            const byteArray = new Uint8Array(byteNumbers);
            const blob = new Blob([byteArray], { type: "image/png" });
            const reader = new FileReader();
            reader.onloadend = function ()
            {
                console.log("Blob tartalom:", reader.result);
            };
            reader.readAsText(blob);
            setImageUrl(URL.createObjectURL(blob)); // Itt állítsd be az imageUrl-t
        } else {
            return <div>Nincs kép vagy betöltés...</div>;
        }
    };

    return (
        <div className={`main-container ${darkMode ? "dark-main-container" : ""}`}>
            <div className="picture-game-main-container">

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

                    <div className={`slider-container ${darkMode ? "dark-blur-container" : ""}`}>

                        <div className={`slider-text ${darkMode ? "dark-text" : ""}`}>
                            {text.numberofanswers}
                        </div>

                        <input
                            className={`answer-slider ${darkMode ? "dark-answer-slider" : ""}`}
                            type="range"
                            min="2"
                            max="10"
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
                    <div className={`picture-game-blur-container ${darkMode ? "picture-dark-blur-container" : ""}`}>
                        <div className="content">

                            <div className={`picture-numbers ${darkMode ? "dark-numbers" : ""}`}>
                                {Array.from(
                                    { length: numAnswers }).map(
                                        (_, index) => (
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

                            <div className="picture-button-container">

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

export default Picture_Game;