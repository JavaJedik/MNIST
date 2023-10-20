import React, {useState, useEffect} from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles.css"
//import AuthService from '../AuthService';

const Admin = () => {

    const navigate = useNavigate();
    const [answer, setText] = useState('');
    const [pic, setPicture] = useState(null);

    const navigateLogin = () => {
        //localStorage.removeItem('userToken');
        navigate("/login");
    };

    const sendPicture = () => {
        alert(`küldött válasz: ${answer} ... ${pic}`);
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
                    value={pic}
                    placeholder="file"
                    onChange={(e) => setPicture(e.target.value)}
                    id="file_uploader"
                />

                <div className="content">
                    <input
                        className="input-field"
                        type="text"
                        maxLength="1"
                        placeholder="Helyes válasz (1 karakter)"
                        id="answer"
                        value={answer}
                        onChange={(e) => setText(e.target.value)}
                    />
                </div>

                <div>
                    <button className="home-button-style" onClick={sendPicture}>
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