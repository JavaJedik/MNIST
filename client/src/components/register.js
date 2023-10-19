import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles.css"

const Register = () => {
    const navigate = useNavigate();
    const [selectedLanguageItem, setSelectedLanguageItem] = useState(null);
    const [selectedGenderItem, setSelectedGenderItem] = useState(null);
    const [isDropdownOpenLanguage, setIsDropdownOpenLanguage] = useState(false);
    const [isDropdownOpenGender, setIsDropdownOpenGender] = useState(false);

    const navigateLogin = () => {
        navigate("/login");
    };

    const handleLanguageDropdownItemClick = (item) => {
        setSelectedLanguageItem(item);
        setIsDropdownOpenLanguage(false)
        //setIsDropdownOpenGender(false);
    };

    const handleGenderDropdownItemClick = (item) => {
        setSelectedGenderItem(item);
        setIsDropdownOpenGender(false);
    }

    return (
        <div className="main-container">
            <div className = "reg-blur-container"></div>
            <div className = "reg-container">
                <div className = "content">
                    <input
                        className= "input-field"
                        type="text"
                        placeholder="Felhasználónév"
                        id="username"
                    />
                </div>
                <div className = "content">
                    <input
                        className= "input-field"
                        type="text"
                        placeholder="E-mail cím"
                        id="email"
                    />
                </div>
                <div className = "content">
                    <input
                        className= "input-field"
                        type="password"
                        placeholder="Jelszó"
                        id="password"
                    />
                </div>
                <div className = "content">
                    <input
                        className= "input-field"
                        type="password"
                        placeholder="Jelszó mégegyszer"
                        id="password-check"
                    />
                </div>
                <div className={`dropdown ${isDropdownOpenLanguage ? "active-language" : ""}`}>
                    <button className="dropbtn" onClick={() => setIsDropdownOpenLanguage(!isDropdownOpenLanguage)}>
                        <span>
                            {selectedLanguageItem || "Itt lesz a nyelv.."}
                        </span>
                        <span className="dropbtn-arrow">
                            &#9660;
                        </span>
                    </button>
                    <div id="myDropdown">
                        <div className="dropdown-content-language">
                            <p onClick={() => handleLanguageDropdownItemClick("Magyar")}>Magyar</p>
                            <p onClick={() => handleLanguageDropdownItemClick("Angol")}>Angol</p>
                        </div>
                    </div>
                </div>
                <div className={`dropdown ${isDropdownOpenGender ? "active-gender" : ""}`}>
                    <button className="dropbtn" onClick={() => setIsDropdownOpenGender(!isDropdownOpenGender)}>
                        <span>
                            {selectedGenderItem || "Adja meg a nemét!"}
                        </span>
                        <span className="dropbtn-arrow">
                            &#9660;
                        </span>
                    </button>
                    <div id="myDropdown">
                        <div className="dropdown-content-gender">
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
                        className= "button-style">
                        Regisztráció
                    </button>
                </div>
            </div>
        </div>
    );
};

export default Register;