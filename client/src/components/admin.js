import React, {useState, useEffect} from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles.css"
import authService from "../AuthService";
import {content} from "./contents/adminContent";

const Admin = () => {

    const navigate = useNavigate();
    const [answer, setText] = useState('');
    const [pic, setPicture] = useState(null);
    const [darkMode, setDarkMode] = useState(false);

    const selectedLanguage = localStorage.getItem("language");
    const text = content[selectedLanguage];

    const setLocalStorageItems = () => {
        localStorage.setItem("language", selectedLanguage);
        localStorage.setItem("darkMode", JSON.stringify(darkMode));
    }

    const navigateLogin = () => {
        //localStorage.removeItem('userToken');
        setLocalStorageItems();
        navigate("/login");
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

            <div className={`admin-blur-container ${darkMode ? "dark-blur-container" : ""}`} />
            <div className="admin-container">
                <div>
                    <h1 className={`admin-header ${darkMode ? "dark-content-bottom" : ""}`}>
                        {text.welcome}
                    </h1>
                </div>

                <input
                    className={`file-upload file-upload-clickable ${darkMode ? "dark-input-field" : ""}`}
                    type="file"
                    accept=".png, .jpg, .jpeg, .svg, .gif"
                    value={pic}
                    placeholder="file"
                    onChange={(e) => setPicture(e.target.value)}
                    id="file_uploader"
                />

                <div className="content">
                    <input
                        className={`file-upload one-char-answer ${darkMode ? "dark-input-field dark-one-char-answer" : ""}`}
                        type="text"
                        maxLength="1"
                        placeholder={text.answerplaceholder}
                        id="answer"
                        value={answer}
                        onChange={(e) => setText(e.target.value)}
                    />
                </div>

                <div>
                    <button
                        className={`home-button-style ${darkMode ? "dark-button-style" : ""}`}
                        onClick={() => authService.sendPicture(pic, answer)}
                    >
                        {text.upload}
                    </button>
                </div>

                <div>
                    <button
                        className={`home-button-style ${darkMode ? "dark-button-style" : ""}`}
                        onClick={navigateLogin}
                    >
                        {text.logout}
                    </button>
                </div>
            </div>

        </div>
    );
};

export default Admin;