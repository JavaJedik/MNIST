import React, {useState, useEffect} from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles/admin.css"
import authService from "../AuthService";
import { content } from "./contents/adminContent";
import { changer } from "./changer";

const Admin = () => {

    const navigate = useNavigate();
    const [answer, setText] = useState('');
    const [pic, setPicture] = useState(null);
    const [picByteArray, setPicByteArray] = useState(null);

    const [darkMode, setDarkMode] = useState(changer.darkMode);
    const [selectedLanguage, setSelectedLanguage] = useState(changer.language);

    const token = localStorage.getItem('userToken');

    const text = content[selectedLanguage];

    const navigateLogin = () => {
        //localStorage.removeItem('userToken');
        changer.setChangerItems(selectedLanguage, darkMode);
        navigate("/login");
    };

    const handleFileChange = (e) => {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();

            reader.onload = (e) => {
                const arrayBuffer = e.target.result;
                const byteArray = new Uint8Array(arrayBuffer);

                setPicByteArray(byteArray);
            };

            reader.readAsArrayBuffer(file);
            setPicture(e.target.value);
        }
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
                    placeholder="file"
                    onChange={handleFileChange}
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
                        onClick={() => authService.sendPicture(
                            token, picByteArray, answer, "number", 1)}
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