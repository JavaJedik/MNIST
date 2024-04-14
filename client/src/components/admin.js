import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles/styles.css";
import authService from "../AuthService";
import { content } from "./contents/adminContent";
import { changer } from "./changer";

const Admin = () => {
    const navigate = useNavigate();
    const [pictureAnswer, setPictureAnswer] = useState('');
    const [pictureType, setPictureType] = useState('');
    const [collectionType, setCollectionType] = useState('');
    const [isCollectionDropdownOpenUpload, setIsCollectionDropdownOpenUpload] = useState(false);
    const [isTypeDropdownOpenUpload, setIsTypeDropdownOpenUpload] = useState(false);
    const [darkMode, setDarkMode] = useState(changer.darkMode);
    const [selectedLanguage, setSelectedLanguage] = useState(changer.language);
    const [newPictureArrays, setNewPictureArrays] = useState([]);
    const token = localStorage.getItem('userToken');
    const text = content[selectedLanguage];

    useEffect(() => {
        const fetchData = async () => {
            try {
                const data = await authService.checkLoggedIn();
                if (data !== 200 || data === null) {
                    throw new Error("Hiba a token ellenőrzésében!");
                }
            } catch (error) {
                console.error('Hiba az autentikációs ellenőrzésben:', error);
                alert(`Hiba az autentikációs ellenőrzésben: ${error}`);
                navigateLogin();
            }
        };
        fetchData();
    }, []);

    const navigateLogin = () => {
        localStorage.removeItem('userToken');
        changer.setChangerItems(selectedLanguage, darkMode);
        navigate("/login");
    };

    const handleFileChange = (e) => {
        const files = e.target.files;
        if (files.length > 0) {
            const newArrays = [];
            for (let i = 0; i < files.length; i++) {
                const reader = new FileReader();
                reader.onload = (event) => {
                    const byteArray = new Uint8Array(event.target.result);
                    newArrays.push(byteArray);
                    if (newArrays.length === files.length) {
                        setNewPictureArrays(newArrays);
                    }
                };
                reader.readAsArrayBuffer(files[i]);
            }
        }
    };

    const languageChange = () => {
        setSelectedLanguage(prevLang => (prevLang === "HUN" ? "ENG" : "HUN"));
    };

    const handleTypeDropdownItemClick = (item) => {
        setPictureType(item)
        setIsTypeDropdownOpenUpload(false);
    };
    
    const handleCollectionDropdownItemClick = (item) => {
        setCollectionType(item)
        setIsCollectionDropdownOpenUpload(false);
    };

    const handleUploadClick = () => {
        authService.sendPictures(
            token, 
            newPictureArrays,
            selectedLanguage,
            collectionType,
            pictureType, 
            pictureAnswer
        );
    };

    return (
    <div className={`main-container ${darkMode ? "dark-main-container" : ""}`}>

        <label className="switch">
            <input
                defaultChecked={false}
                type="checkbox"
                checked={darkMode}
                onChange={() => setDarkMode(prevState => !prevState)}
            />
            <span className={`slider round ${darkMode ? "dark-slider" : ""}`} />
        </label>

        <div className="language-changer" onClick={() => languageChange()} />

        <div className={`admin-blur-container ${darkMode ? "dark-blur-container" : ""}`} />
        <div className="admin-container">
            <div>
                <h1 className={`admin-header ${darkMode ? "dark-content-bottom" : ""}`}>
                    {text.welcome}
                </h1>
            </div>
            <input
                className={`file-upload file-upload-clickable ${darkMode ? "dark-input-field" : ""}`}
                type="file"
                accept=".png, .jpg, .jpeg, .svg, .gif"
                placeholder="file"
                onChange={handleFileChange}
                id="file_uploader"
                multiple
            />
            
            <div className={`dropdown ${isCollectionDropdownOpenUpload ? "active-upload" : ""}`}>
                <button
                    className={`dropbtn ${darkMode ? "dark-button-style" : ""}`}
                    onClick={() => setIsCollectionDropdownOpenUpload(!isCollectionDropdownOpenUpload)}
                >
                    <span>
                        {collectionType || text.chooseC}
                    </span>
                    <span className="dropbtn-arrow">
                        &#9660;
                    </span>
                </button>

                <div id="myDropdown1">
                    <div className={`dropdown-content-upload ${darkMode ? "dark-dropdown-content" : ""}`}>
                        <p onClick={() => handleCollectionDropdownItemClick(text.number)}>
                            {text.number}
                        </p>
                        <p onClick={() => handleCollectionDropdownItemClick(text.dog_and_cat)}>
                            {text.dog_and_cat}
                        </p>
                    </div>
                </div>
            </div>

            <div className={`dropdown ${isTypeDropdownOpenUpload ? "active-upload" : ""}`}>
                <button
                    className={`dropbtn ${darkMode ? "dark-button-style" : ""}`}
                    onClick={() => setIsTypeDropdownOpenUpload(!isTypeDropdownOpenUpload)}
                >
                    <span>
                        {pictureType || text.choose}
                    </span>
                    <span className="dropbtn-arrow">
                        &#9660;
                    </span>
                </button>

                <div id="myDropdown">
                    <div className={`dropdown-content-upload ${darkMode ? "dark-dropdown-content" : ""}`}>
                        <p onClick={() => handleTypeDropdownItemClick(text.number)}>
                            {text.number}
                        </p>
                        <p onClick={() => handleTypeDropdownItemClick(text.animal)}>
                            {text.animal}
                            </p>
                    </div>
                </div>
            </div>
            
            <div className="content">
                <input
                    className={`input-field ${darkMode ? "dark-input-field" : ""}`}
                    type="text"
                    placeholder={text.picture_data} // A helyőrző szöveg az "Adatok a képről" lehet
                    value={pictureAnswer} // A korábban dataForPicture-nek szánt mező most pictureAnswer állapotot fogja frissíteni
                    onChange={(e) => setPictureAnswer(e.target.value)}
                    id="picturedata"
                />
            </div>

            <div>
                <button
                    className={`home-button-style ${darkMode ? "dark-button-style" : ""}`}
                    onClick={() => handleUploadClick()}
                >
                    {text.upload}
                </button>
            </div>

            <div>
                <button
                    className={`home-button-style ${darkMode ? "dark-button-style" : ""}`}
                    onClick={navigateLogin}
                >
                    {text.logout}
                </button>
            </div>
        </div>
    </div>
    );
};

export default Admin;