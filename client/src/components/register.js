import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles.css"

const Register = () => {
    const navigate = useNavigate();
    const [selectedItem, setSelectedItem] = useState(null);
    const [isDropdownOpenCountry, setIsDropdownOpenCountry] = useState(false);
    const [isDropdownOpenGender, setIsDropdownOpenGender] = useState(false);

    const navigateLogin = () => {
        navigate("/login");
    };

    const handleDropdownItemClick = (item) => {
        setSelectedItem(item);
        setIsDropdownOpenCountry(false)
        setIsDropdownOpenGender(false);
    };

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
                <div className={`dropdown ${isDropdownOpenCountry ? "active-country" : ""}`}>
                    <button className="dropbtn" onClick={() => setIsDropdownOpenCountry(!isDropdownOpenCountry)}>
                        <span>
                            {selectedItem || 'Adja meg a nemét!'}
                        </span>
                        <span className="dropbtn-arrow">
                            &#9660;
                        </span>
                    </button>
                    <div id="myDropdown">
                        <div className="dropdown-content">
                            <p onClick={() => handleDropdownItemClick("Férfi")}>Férfi</p>
                            <p onClick={() => handleDropdownItemClick("Nő")}>Nő</p>
                            <p onClick={() => handleDropdownItemClick("Macska")}>Macska</p>
                        </div>
                    </div>
                </div>
                <div className={`dropdown ${isDropdownOpenGender ? "active-gender" : ""}`}>
                    <button className="dropbtn" onClick={() => setIsDropdownOpenGender(!isDropdownOpenGender)}>
                        <span>
                            {selectedItem || 'Adja meg a nemét!'}
                        </span>
                        <span className="dropbtn-arrow">
                            &#9660;
                        </span>
                    </button>
                    <div id="myDropdown">
                        <div className="dropdown-content">
                            <p onClick={() => handleDropdownItemClick("Férfi")}>Férfi</p>
                            <p onClick={() => handleDropdownItemClick("Nő")}>Nő</p>
                            <p onClick={() => handleDropdownItemClick("Macska")}>Macska</p>
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