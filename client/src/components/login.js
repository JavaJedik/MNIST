import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
//import AuthService from '../AuthService';

const Login = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const navigate = useNavigate();

    /*const navigateHome = async () => {
        try {
            const data = await AuthService.login(username, password);

            if (data.success) {
                navigate('/home');
            } else {
                alert('Sikertelen bejelentkezés. Rossz felhasználónév vagy jelszó.');
            }
        } catch (error) {
            console.error('Login failed:', error);
        }
    };*/

    const navigateRegister = () => {
        navigate('/register');
    };

    return (
        <div className="main-container">
            <div className="blur-container"></div>
            <div className="container">
                <div className="content">
                    <input
                        className="input-field"
                        type="text"
                        placeholder="Felhasználónév"
                        id="username"
                        value={username}
                        onChange={(e) => setUsername(e.target.value)}
                    />
                </div>
                <div className="content">
                    <input
                        className="input-field"
                        type="password"
                        placeholder="Jelszó"
                        id="password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                    />
                </div>
                <div className="content">
                    <button className="button-style" onClick={navigateHome}>
                        Bejelentkezés
                    </button>
                    <button className="button-style" onClick={navigateRegister}>
                        Regisztráció
                    </button>
                </div>
                <div>
                    <p className="content-bottom">Jelentkezz be, vagy regisztrálj a kezdéshez!</p>
                </div>
            </div>
        </div>
    );
};

export default Login;