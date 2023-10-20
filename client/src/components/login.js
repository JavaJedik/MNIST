import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles.css"
import AuthService from '../AuthService';

const Login = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [darkMode, setDarkMode] = useState(false);
    const navigate = useNavigate();

    const navigateHome = async () => {
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
        navigate('/register');
        console.log('Regisztrációs oldal megnyitása.')
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

            <div className={`classname ${darkMode ? "dark" : ""}`} />

            <div className={`blur-container ${darkMode ? "dark-blur-container" : ""}`} />
            <div className="container">
                <div className="content">
                    <input
                        className={`input-field ${darkMode ? "dark-input-field" : ""}`}
                        type="text"
                        placeholder="Felhasználónév"
                        id="username"
                        value={username}
                        onChange={(e) => setUsername(e.target.value)}
                    />
                </div>
                <div className="content">
                    <input
                        className={`input-field ${darkMode ? "dark-input-field" : ""}`}
                        type="password"
                        placeholder="Jelszó"
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
                        Bejelentkezés
                    </button>
                    <button
                        className="button-style"
                        className={`button-style ${darkMode ? "dark-button-style" : ""}`}
                        onClick={navigateRegister}
                    >
                        Regisztráció
                    </button>
                </div>
                <div>
                    <p className={`content-bottom ${darkMode ? "dark-content-bottom" : ""}`}>
                        Jelentkezz be, vagy regisztrálj a kezdéshez!
                    </p>
                </div>
            </div>
        </div>
    );
};

export default Login;