import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles.css"
import AuthService from "../AuthService";

const Register = () => {
    const navigate = useNavigate();
    const [selectedLanguageItem, setSelectedLanguageItem] = useState(null);
    const [selectedGenderItem, setSelectedGenderItem] = useState(null);
    const [isDropdownOpenLanguage, setIsDropdownOpenLanguage] = useState(false);
    const [isDropdownOpenGender, setIsDropdownOpenGender] = useState(false);
    const [darkMode, setDarkMode] = useState(false);

    const [username, setUsername] = useState('');
    const [email, setEmail] = useState('');
    const [password1, setPassword1] = useState('');
    const [password2, setPassword2] = useState('');

    const navigateLogin = () => {
        navigate("/login");
    };

    const validateUserData = async () => {
        try {
            if (username === null || username === '' // A kitörlés miatt kell, mert akkor már nem null lesz.
                || email === null || email === ''
                || password1 === null || password1 === ''
                || password2 === null || password2 === ''
                || selectedLanguageItem === null
                || selectedGenderItem === null) {
                throw new Error('Hiányzó adatok!')
            } else if (password1 !== password2) {
                throw new Error('A jelszavak nem egyeznek!')
            } else {
                await registerUser()
            }
        } catch (error) {
            console.error(error)
            alert(error)
        }
    }

    const registerUser = async () => {
        try {
            /*const country = await getCurrentLocation();
            console.log(country)*/

            const data = await AuthService.registerUser(username, email, password1,
                selectedLanguageItem, selectedGenderItem);

            if (data.success) {
                alert('Az adatok mentése sikeres!')
                console.log('Az adatok mentése sikeres!')
                navigate("/home")
            } else {
                alert('Az adatok mentése sikertelen!')
                console.log('Az adatok mentése sikertelen!')
                throw new Error('Az adatok mentése sikertelen!')
            }
        } catch (error) {
            console.error(error)
            alert(error)
        }
    }

    const handleLanguageDropdownItemClick = (item) => {
        setSelectedLanguageItem(item);
        setIsDropdownOpenLanguage(false)
    };

    const handleGenderDropdownItemClick = (item) => {
        setSelectedGenderItem(item);
        setIsDropdownOpenGender(false);
    }

    function isValidEmail(checkEmail) {
        const emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
        return emailRegex.test(checkEmail);
    }

    function isLessStrongPassword(checkPassword) {
        // Minimum 6 karakter, közte 1 szám és 1 nagybetű.
        const passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d).{6,}$/;
        return passwordRegex.test(checkPassword);
    }

    /*async function getCurrentLocation() {
        try {
            const position = await new Promise((resolve, reject) => {
                navigator.geolocation.getCurrentPosition(resolve, reject);
            });

            const { latitude, longitude } = position.coords;

            const response = await fetch(
                `https://nominatim.openstreetmap.org/reverse?format=json&lat=${latitude}&lon=${longitude}`,
                {
                    headers: {
                        'Accept-Language': 'hu'
                    }
                }
            );

            const data = await response.json();

            if (data.display_name) {
                const locationName = data.display_name;
                return locationName;
            } else {
                throw new Error("Sikertelen helymeghatározás, alapértelmezett: Magyarország.")
            }
        } catch (error) {
            console.error(error)
            return "Magyarország";
        }
    }*/

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

            <div  className={`reg-blur-container ${darkMode ? "dark-blur-container" : ""}`}/>
            <div className = "reg-container">
                <div className = "content">
                    <input
                        className={`input-field ${darkMode ? "dark-input-field" : ""}`}
                        type="text"
                        placeholder="Felhasználónév"
                        id="username"
                        value={username}
                        onChange={(e) => setUsername(e.target.value)}
                    />
                </div>
                <div className = "content">
                    <input
                        className={`input-field ${darkMode ? "dark-input-field" : ""}`}
                        type="text"
                        placeholder="E-mail cím"
                        id="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                    />
                </div>
                <div className = "content">
                    <input
                        className={`input-field ${darkMode ? "dark-input-field" : ""}`}
                        type="password"
                        placeholder="Jelszó"
                        id="password1"
                        value={password1}
                        onChange={(e) => setPassword1(e.target.value)}
                    />
                </div>
                <div className = "content">
                    <input
                        className={`input-field ${darkMode ? "dark-input-field" : ""}`}
                        type="password"
                        placeholder="Jelszó mégegyszer"
                        id="password2"
                        value={password2}
                        onChange={(e) => setPassword2(e.target.value)}
                    />
                </div>
                <div className={`dropdown ${isDropdownOpenLanguage ? "active-language" : ""}`}>
                    <button
                        className={`dropbtn ${darkMode ? "dark-button-style" : ""}`}
                        onClick={() => setIsDropdownOpenLanguage(!isDropdownOpenLanguage)}
                    >
                        <span>
                            {selectedLanguageItem || "Válasszon nyelvet!"}
                        </span>
                        <span className="dropbtn-arrow">
                            &#9660;
                        </span>
                    </button>
                    <div id="myDropdown">
                        <div className={`dropdown-content-language ${darkMode ? "dark-dropdown-content" : ""}`}>
                            <p onClick={() => handleLanguageDropdownItemClick("Magyar")}>
                                Magyar
                            </p>
                            <p onClick={() => handleLanguageDropdownItemClick("Angol")}>
                                Angol
                            </p>
                        </div>
                    </div>
                </div>
                <div className={`dropdown ${isDropdownOpenGender ? "active-gender" : ""}`}>
                    <button
                        className={`dropbtn ${darkMode ? "dark-button-style" : ""}`}
                        onClick={() => setIsDropdownOpenGender(!isDropdownOpenGender)}>
                        <span>
                            {selectedGenderItem || "Adja meg a nemét!"}
                        </span>
                        <span className="dropbtn-arrow">
                            &#9660;
                        </span>
                    </button>
                    <div id="myDropdown">

                        <div className={`dropdown-content-gender ${darkMode ? "dark-dropdown-content" : ""}`}>
                            <p onClick={() => handleGenderDropdownItemClick("Férfi")}>Férfi</p>
                            <p onClick={() => handleGenderDropdownItemClick("Nő")}>Nő</p>
                            <p onClick={() => handleGenderDropdownItemClick("Macska")}>Macska</p>
                        </div>
                    </div>
                </div>
                <div className = "content">
                    <button
                        className= "button-style"
                        onClick={navigateLogin}>
                        Vissza
                    </button>
                    <button
                        className= "button-style"
                        onClick={validateUserData}>
                        Regisztráció
                    </button>
                </div>
            </div>
        </div>
    );
};

export default Register;