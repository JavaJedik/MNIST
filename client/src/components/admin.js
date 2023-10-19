import React, {useState, useEffect} from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles.css"
//import AuthService from '../AuthService';

const Admin = () => {

    const navigate = useNavigate();

    const navigateLogin = () => {
        //localStorage.removeItem('userToken');
        navigate("/login");
    };

    return (
        <div className="main-container">
            <div className="admin-blur-container" />
            <div className="admin-container">
                <div>
                    <h1 className="admin-header">
                        Üdvözöljük, Admin!
                    </h1>
                </div>

                <input
                    className="file-upload"
                    type="file"
                    accept=".png, .jpg, .jpeg, .svg, .gif"
                    id="file_uploader"
                />

                <div className="content">
                    <input
                        className="input-field"
                        type="text"
                        placeholder="Helyes válasz"
                        id="answer"
                    />
                </div>

                <div>
                    <button className="home-button-style">
                        Fájl feltöltése
                    </button>
                </div>

                <div>
                    <button className="home-button-style" onClick={navigateLogin}>
                        Kijelentkezés
                    </button>
                </div>
            </div>

        </div>
    );
};

export default Admin;