import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import "./styles/styles.css"
import authService from "../AuthService";
import { content } from "./contents/adminContent";
import { changer } from "./changer";
import AuthService from "../AuthService";

const Admin = () => {

    const navigate = useNavigate();
    const [answer, setText] = useState('');
    const [pic, setPicture] = useState(null);
    const [picByteArray, setPicByteArray] = useState(null);

    const [selectedUploadItem, setSelectedUploadItem] = useState(null);
    const [isDropdownOpenUpload, setIsDropdownOpenUpload] = useState(false);

    const [darkMode, setDarkMode] = useState(changer.darkMode);
    const [selectedLanguage, setSelectedLanguage] = useState(changer.language);

    const [pictureNames, setPictureNames] = useState([]);
    const [pictureArrays, setPictureArrays] = useState([]);
    const [newPictureArrays, setNewPictureArrays] = useState([]);



    const token = localStorage.getItem('userToken');

    const text = content[selectedLanguage];

    useEffect(() => {
        const fetchData = async () => {
            try {
                const data = await AuthService.checkLoggedIn();
                console.log(data)

                if (data !== 200 || data === null) {
                    throw new Error("Hiba a token ellenőrzésében!")
                }

            } catch (error) {
                console.error('Hiba az autentikációs ellenőrzésben:', error);
                alert(`Hiba az autentikációs ellenőrzésben: ${error}`);
                navigateLogin()
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
            const newPictureArrays = [];

            for (let i = 0; i < files.length; i++) {
                const file = files[i];
                const reader = new FileReader();

                reader.onload = (e) => {
                    const arrayBuffer = e.target.result;
                    const byteArray = new Uint8Array(arrayBuffer);

                    newPictureArrays.push(byteArray);

                    if (newPictureArrays.length === files.length) {
                        setNewPictureArrays(newPictureArrays);
                    }
                };

                reader.readAsArrayBuffer(file);
            }
            console.log(newPictureArrays)
            console.log(setPictureArrays)


            /*const newPictureNames = Array.from(files).map(file => file.name);
            setPictureNames(newPictureNames);

            console.log(newPictureNames)
            console.log(setPictureNames)*/
        }
    };

    console.log(newPictureArrays)

    const languageChange = () => {
        if(selectedLanguage === "HUN") {
            setSelectedLanguage("ENG");
        }
        else if(selectedLanguage === "ENG") {
            setSelectedLanguage("HUN");
        }
    }

    const handleDropdownItemClick = (upload) => {
        setSelectedUploadItem(upload);
        setIsDropdownOpenUpload(false);
    }

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

            <div
                className="language-changer"
                onClick={() => languageChange()}
            />

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

                <div className={`dropdown ${isDropdownOpenUpload ? "active-upload" : ""}`}>

                    <button
                        className={`dropbtn ${darkMode ? "dark-button-style" : ""}`}
                        onClick={() => setIsDropdownOpenUpload(!isDropdownOpenUpload)}
                    >

                        <span>
                            {selectedUploadItem || text.choose}
                        </span>

                        <span className="dropbtn-arrow">
                            &#9660;
                        </span>

                    </button>

                    <div id="myDropdown">

                        <div className={`dropdown-content-upload ${darkMode ? "dark-dropdown-content" : ""}`}>

                            <p onClick={() => handleDropdownItemClick(text.number)}>
                                {text.number}
                            </p>

                            <p onClick={() => handleDropdownItemClick(text.dog_and_cat)}>
                                {text.dog_and_cat}
                            </p>

                        </div>

                    </div>

                </div>

                <div>
                    <button
                        className={`home-button-style ${darkMode ? "dark-button-style" : ""}`}
                        onClick={() => authService.sendPictures(
                            token, newPictureArrays, selectedUploadItem)}
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