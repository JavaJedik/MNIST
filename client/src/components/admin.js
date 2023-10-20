import React, {useState, useEffect} from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles.css"
//import AuthService from '../AuthService';

const Admin = () => {

    const navigate = useNavigate();
    const [answer, setText] = useState('');
    const [pic, setPicture] = useState(null);
    const [darkMode, setDarkMode] = useState(false);

    const navigateLogin = () => {
        //localStorage.removeItem('userToken');
        navigate("/login");
    };

    const sendPicture = () => {
        alert(`küldött válasz: ${answer} ... ${pic}`);
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
                <span className="slider round"></span>
            </label>

            <div className={`admin-blur-container ${darkMode ? "dark-blur-container" : ""}`} />
            <div className="admin-container">
                <div>
                    <h1 className={`admin-header ${darkMode ? "dark-content-bottom" : ""}`}>
                        Üdvözöljük, Admin!
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
                        className={`file-upload ${darkMode ? "dark-input-field" : ""}`}
                        type="text"
                        maxLength="1"
                        placeholder="Helyes válasz (1 karakter)"
                        id="answer"
                        value={answer}
                        onChange={(e) => setText(e.target.value)}
                    />
                </div>

                <div>
                    <button
                        className={`home-button-style ${darkMode ? "dark-button-style" : ""}`}
                        onClick={sendPicture}
                    >
                        Fájl feltöltése
                    </button>
                </div>

                <div>
                    <button
                        className={`home-button-style ${darkMode ? "dark-button-style" : ""}`}
                        onClick={navigateLogin}
                    >
                        Kijelentkezés
                    </button>
                </div>
            </div>

        </div>
    );
};

export default Admin;