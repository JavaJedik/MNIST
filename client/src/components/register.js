import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

const Register = () => {
    const navigate = useNavigate();
    const [selectedItem, setSelectedItem] = useState(null);

    const navigateLogin = () => {
        navigate("/login");
    };

    const handleDropdownItemClick = (item) => {
        setSelectedItem(item);
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
                <div className="dropdown">
                    <button
                        className="dropbtn">
                        {selectedItem || "Adja meg a nemét!"}
                    </button>
                    <div id="myDropdown">
                        <div className="dropdown-content">
                            <p onClick={() => handleDropdownItemClick("Most nem válaszolnék")}>Most nem válaszolnék</p>
                            <p onClick={() => handleDropdownItemClick("Férfi")}>Férfi</p>
                            <p onClick={() => handleDropdownItemClick("Nő")}>Nő</p>
                            <p onClick={() => handleDropdownItemClick("Nő")}>Macska</p>
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