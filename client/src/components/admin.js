import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles.css"
//import AuthService from '../AuthService';

const Admin = () => {

    return(
        <div className="main-container">
            <div className="admin-blur-container" />
            <div className="admin-container">
                <div>
                    <h1 className="admin-header">
                        Üdvözöljük, Admin!
                    </h1>
                </div>

                

                <div>
                    <button className="home-button-style">
                        Kijelentkezés
                    </button>
                </div>
            </div>

        </div>
    );
};

export default Admin;