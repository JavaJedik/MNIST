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
    const [responseArray, setResponseArray] = useState([]);
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

    const setLocalStorageItems = () => {
        localStorage.setItem("language", selectedLanguage);
        localStorage.setItem("darkMode", JSON.stringify(darkMode));
    }

    const navigateHome = () => {
        setLocalStorageItems();
        changer.setChangerItems(selectedLanguage, darkMode);
        navigate('/home');
    };

    const navigateLeaderboard = () => {
        setLocalStorageItems();
        changer.setChangerItems(selectedLanguage, darkMode);
        navigate('/leaderboard');
    };

    /* useEffect(() => {
        document.addEventListener('keydown', handleKeyPress);

        const fetchData = async () => {
            try {
                const response = await AuthService.askPicture(localStorage.getItem("gameToken"), 5);
                if (response.success) {
                    console.log("A gamere érkezett adatok: ", response.response)
                    setPictures(response.response); // Az összes képet beállítjuk
                    console.log("A képek: ", pictures)
                    setCurrentPictureIndex(0); // Az első képet állítjuk be kezdetben
                } else {
                    navigateLogin();
                }
            } catch (error) {
                console.error("Képek lekérése sikertelen", error);
            }
        };

        fetchData();

        return () => {
            document.removeEventListener('keydown', handleKeyPress);
        };
    }, []); */

    useEffect(() => {
        const fetchData = async () => {
            try {
                const response = await AuthService.askPicture(localStorage.getItem("gameToken"), 5);
                if (response.success) {
                    console.log("A gamere érkezett adatok: ", response.response);
                    setPictures(response.response); // Az összes képet beállítjuk
                } else {
                    navigateLogin();
                }
            } catch (error) {
                console.error("Képek lekérése sikertelen", error);
            }
        };

        fetchData();

    }, []);

    useEffect(() => {
        console.log("A képek: ", pictures);

        if (pictures.length > 0) {
            setCurrentPictureIndex(0);
            renderCurrentPicture();
        }

    }, [pictures]);

    const renderCurrentPicture = async () => {
        console.log("A képek száma: ", pictures.length);
        if (pictures && pictures.length > 0 && currentPictureIndex >= 0 && currentPictureIndex < pictures.length) {
            const currentPicture = pictures[currentPictureIndex];

            const newResponseArray = [currentPicture.answerOptions];
            setResponseArray(newResponseArray);
            setNumberOfAnswers(newResponseArray.length);

            console.log("Response Array:", newResponseArray);
            console.log("Answer of First Button: ", newResponseArray[0][0].answer);
            console.log("Number of Answers", numberOfAnswers);

            const base64ImageData = currentPicture.pictureBytes;
            const byteCharacters = atob(base64ImageData);
            const byteNumbers = new Array(byteCharacters.length);

            for (let i = 0; i < byteCharacters.length; i++) {
                byteNumbers[i] = byteCharacters.charCodeAt(i);
            }

            const byteArray = new Uint8Array(byteNumbers);
            const blob = new Blob([byteArray], { type: "image/png" });

            const reader = new FileReader();

            reader.onloadend = function () {
                console.log("Blob tartalom:");
            };

            reader.readAsText(blob);
            setImageUrl(URL.createObjectURL(blob)); // Itt állítsd be az imageUrl-t
        } else {
            return <div>Nincs kép vagy betöltés...</div>;
        }
    };

    useEffect(() => {
        renderCurrentPicture();
    }, [currentPictureIndex, pictures]);

    const handleClick = (element) => {
        alert("A válaszod: " + element);
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

                </div>

                <div className="game-right-container">
                    <div className={`picture-game-blur-container ${darkMode ? "picture-dark-blur-container" : ""}`}>
                        <div className="content">

                            <div className={`picture-numbers ${darkMode ? "dark-numbers" : ""}`}>
                                {responseArray[0] ? (
                                    responseArray[0].map((element, index) => (
                                        <div
                                            className="picture-number"
                                            onClick={() => handleClick(element.answer)}
                                            key={index}
                                        >
                                            <button
                                                className={`number-button ${darkMode ? "dark-number-button" : ""}`}
                                            >
                                                {element.answer}
                                            </button>
                                        </div>
                                    ))
                                ) : (
                                    <>
                                        <p>Betöltés!</p>
                                    </>
                                )}
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