import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles.css"
import AuthService from '../AuthService';
import {content} from "./contents/loginContent";

const Login = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [darkMode, setDarkMode] = useState(false);
    const navigate = useNavigate();

    const selectedLanguage = localStorage.getItem("language");
    const text = content[selectedLanguage];

    const setLocalStorageItems = () => {
        localStorage.setItem("language", selectedLanguage);
        localStorage.setItem("darkMode", JSON.stringify(darkMode));
    }

    const navigateHome = async () => {
        setLocalStorageItems();
        try {
            const data = await AuthService.login(username, password);

            if (data.success) {
                navigate('/home');
                console.log(username + ' felhasználó sikeresen bejelentkezett.')
            } else {
                alert('Sikertelen bejelentkezés. Rossz felhasználónév vagy jelszó.');
                console.log('Sikertelen bejelentkezés. Rossz felhasználónév vagy jelszó.')
            }
        } catch (error) {
            console.error('Login failed: ', error);
        }
    };

    const navigateRegister = () => {
        setLocalStorageItems();
        navigate('/register');
        console.log('Regisztrációs oldal megnyitása.')
    };

    const navigateHomeAsGuest = async () => {
        setLocalStorageItems();
        try {
            const data = await AuthService.loginAsGuest();

            if (data.success) {
                navigate('/home');
                console.log(username + ' felhasználó sikeresen bejelentkezett.')
            } else {
                alert('Sikertelen bejelentkezés. Rossz felhasználónév vagy jelszó.');
                console.log('Sikertelen bejelentkezés. Rossz felhasználónév vagy jelszó.')
            }
        } catch (error) {
            console.error('Login failed: ', error);
        }
    }

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

            <div className={`blur-container ${darkMode ? "dark-blur-container" : ""}`} />
            <div className="container">

                <div>
                    <p className={`content-bottom ${darkMode ? "dark-content-bottom" : ""}`}>
                        {text.toptext}
                    </p>
                </div>

                <div className="content">
                    <input
                        className={`input-field ${darkMode ? "dark-input-field" : ""}`}
                        type="text"
                        placeholder={text.username}
                        id="username"
                        value={username}
                        onChange={(e) => setUsername(e.target.value)}
                    />
                </div>
                <div className="content">
                    <input
                        className={`input-field ${darkMode ? "dark-input-field" : ""}`}
                        type="password"
                        placeholder={text.password}
                        id="password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                    />
                </div>
                <div className="content">
                    <button
                        className="button-style"
                        className={`button-style ${darkMode ? "dark-button-style" : ""}`}
                        onClick={navigateHome}
                    >
                        {text.login}
                    </button>
                    <button
                        className="button-style"
                        className={`button-style ${darkMode ? "dark-button-style" : ""}`}
                        onClick={navigateRegister}
                    >
                        {text.registration}
                    </button>
                </div>
                <div>
                    <p className={`content-bottom ${darkMode ? "dark-content-bottom" : ""}`}>
                        {text.bottomtext}
                    </p>
                </div>
                <div className="bottom-button">
                    <button
                        className="button-style"
                        className={`button-style ${darkMode ? "dark-button-style" : ""}`}
                        onClick={navigateHomeAsGuest}
                    >
                        {text.guest}
                    </button>
                </div>
            </div>
        </div>
    );
};

export default Login;