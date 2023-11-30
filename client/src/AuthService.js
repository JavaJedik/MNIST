const API_URL = 'https://mnist-server.serveo.net';
/*'https://1c544cddb7c3cfcf4e845eadf5c5ee81.serveo.net';
'https://mnist-server.serveo.net';*/

const AuthService = {

    login: async (username, password) => {
        try {
            // Elküldjük a kérést és kiírjuk a küldött adatokat
            const requestData = {
                username,
                password
            };
            console.log('Küldött adatok:', requestData);

            const response = await fetch(`${API_URL}/login`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(requestData)
            });

            if (response.status === 200) {
                // Ha a státuszkód 200 OK, olvassuk el a választ szövegként
                const responseText = await response.text();
                console.log('Válasz típusa:', typeof responseText);
                console.log('Válasz tartalma:', responseText);

                // Adjunk vissza egy JSON objektumot a válaszból
                localStorage.setItem('userToken', responseText);
                return {success: true, userToken: responseText};
            } else if (response.status === 401) {
                // Ha a státuszkód 401 Unauthorized, nincs válasz
                console.log('Nincs válasz a státuszkód 401 esetén.');

                // Adjunk vissza egy JSON objektumot a válaszból
                return {success: false, userToken: ''};
            } else {
                // Egyéb státuszkódok esetén
                console.log('Nem kezelt státuszkód:', response.status);
                throw new Error('Login failed');
            }
        } catch (error) {
            console.error('Fetch error:', error);
            throw new Error('Login failed');
        }
    },

    loginAsGuest: async () => {
        try {
            const response = await fetch(`${API_URL}/registrate/guest`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                },
            });

            console.log(response)

            if (response.status === 200) {
                const responseText = await response.text();
                console.log('Válasz típusa:', typeof responseText);
                console.log('Válasz tartalma:', responseText);
                localStorage.setItem("userToken", responseText);
                
                return {success: true, userToken: responseText};
            } else if (response.status === 403) {
                console.log('Nincs válasz a státuszkód 403 (Forbidden) esetén.');

                return {success: false, userToken: ''};
            } else {
                console.log('Nem kezelt státuszkód:', response.status);
                throw new Error('Login failed');
            }
        } catch (error) {
            console.error('Fetch error:', error);
            throw new Error('Login failed');
        }
    },

    checkLoggedIn: async () => {
        const userToken = localStorage.getItem('userToken');

        try {
            const response = await fetch(`${API_URL}/check/userToken`, {
                method: 'GET',
                headers: {
                    'userToken': `${userToken}`
                }
            });

            if (response.status === 200) {
                const responseText = await response.text();
                console.log('Válasz típusa:', typeof responseText);
                console.log('Válasz tartalma:', responseText);

                return response.status;
            } else {
                console.log('Nem kezelt státuszkód:', response.status);
                throw new Error('No usertoken');
            }
        } catch (error) {
            console.error('Fetch error:', error);
            throw new Error('Token check failed');
        }
    },

    checkUserToken: async () => {
        try {
            const response = await fetch(`${API_URL}/check_usertoken`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({})
            });

            console.log(response)

            if (response.status === 200) {
                const responseText = await response.text();
                console.log('Válasz típusa:', typeof responseText);
                console.log('Válasz tartalma:', responseText);

                return {success: true, userToken: responseText};
            } else if (response.status === 403) {
                console.log('Nincs válasz a státuszkód 403 (Forbidden) esetén.');

                return {success: false, userToken: ''};
            } else {
                console.log('Nem kezelt státuszkód:', response.status);
                throw new Error('Login failed');
            }
        } catch (error) {
            console.error('Fetch error:', error);
            throw new Error('Login failed');
        }
    },

    registerUser: async (username, email, password, language, gender) => {
        try {
            const requestData = {
                username,
                email,
                password,
                language,
                gender
            };

            console.log('Küldött adatok:', requestData);

            const response = await fetch(`${API_URL}/registrate`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(requestData)
            });

            if (response.status === 200) {
                const responseText = await response.text();
                console.log('Válasz típusa:', typeof responseText);
                console.log('Válasz tartalma:', responseText);

                localStorage.setItem('userToken', responseText);

                return { success: true, userToken: responseText };
            } else if (response.status === 409) {
                console.log('Nincs válasz a státuszkód 409 esetén.');

                return { success: false, userToken: '' };
            } else {
                console.log('Nem kezelt státuszkód:', response.status);
                throw new Error('Registration failed.');
            }
        } catch (error) {
            console.error('Fetch error:', error);
            throw new Error('Registration failed.');
        }
    },

    //const pic = 0;
    //const answer = '';

    /*sendPictures: (userToken, picArrays, pictureType) => {
        let breakFunction = false

        const picArray = picArrays[0]

        if (!picArray) {
            alert("Please select a file before uploading.");
            breakFunction = true;
        }
        if(pictureType === '' || pictureType === null) {
            alert("Please declare the answer for the picture.");
            breakFunction = true;
        }
        if(breakFunction) {
            return;
        }

        console.log("Kép betöltése sikeres!");
        console.log("Az elküldött kép byte tömbje: ", picArray)
        console.log("Az elküldött válasz: ", pictureType)

        /*const pictureAnswerObject = [
            {
                picture_answer_type,
                picture_answer_answer,
                probability
            }
        ];

        console.log(typeof pictureAnswerObject)
        console.log(pic.length)*/

        /*let alma = JSON.stringify(pictureAnswerObject)
        console.log(typeof alma)*/

        /*fetch(`${API_URL}/upload/picture`, {
            method: "POST",
            headers: {
                'userToken': `${userToken}`,
                'pictureType': `${JSON.stringify(pictureType)}`
            },
            body: picArray
        })
            .then((response) => {
                if (response.ok) {
                    alert("File uploaded successfully.");
                } else {
                    alert("File upload failed.");
                }
            })
            .catch((error) => {
                console.error("Error:", error);
            });
    },*/

    sendPictures: (userToken, picArrays, pictureType) => {
        let breakFunction = false

        //const picArray = picArrays[0]

        if (!picArrays) {
            alert("Please select a file before uploading.");
            breakFunction = true;
        }
        if(pictureType === '' || pictureType === null) {
            alert("Please declare the answer for the picture.");
            breakFunction = true;
        }
        if(breakFunction) {
            return;
        }

        console.log("Kép betöltése sikeres!");
        console.log("Az elküldött kép byte tömbje: ", picArrays)
        console.log("Az elküldött válasz: ", pictureType)

        for (let i = 0; i < picArrays.length; i++) {
            const picArray = picArrays[i];

            console.log(`Uploading picture ${i + 1}...`);
            console.log("The byte array of the uploaded picture: ", picArray);
            console.log("The uploaded answer: ", pictureType);

            fetch(`${API_URL}/upload/picture`, {
                method: "POST",
                headers: {
                    'userToken': `${userToken}`,
                    'pictureType': `${JSON.stringify(pictureType)}`
                },
                body: picArray
            })
                .then((response) => {
                    if (response.ok) {
                        console.log(`Picture ${i + 1} uploaded successfully.`);
                    } else {
                        console.log(`Picture ${i + 1} upload failed.`);
                    }
                })
                .catch((error) => {
                    console.error(`Error uploading picture ${i + 1}:`, error);
                });
        }
    },

    askGameToken: async (userToken) => {
        const response = await fetch(`${API_URL}/askToken/gameToken`, {
            method: "GET",
            headers: {
                'userToken': `${userToken}`
            }
        })

        console.log("response.status: " + response.status);

        if(response.status === 200) {
            const responseText= await response.text();
            console.log("Válasz típusa: ", typeof responseText);
            console.log("Válasz tartalma: ", responseText);
            localStorage.setItem("gameToken", responseText);
            return {success: true, userToken: responseText};
        } else {
            console.log("Nem 200 jött vissza");
            console.log("response.status: " + response.status);
            return {success: false, userToken: ''};
        }
    },

    askNumberPicture: async (gameToken, numberOfAskedPictures) => {
        try {
            const response = await fetch(`${API_URL}/game/ask/picture/number`, {
                method: "GET",
                headers: {
                    'gameToken': gameToken,
                    'numberOfAskedPictures': numberOfAskedPictures
                }
            });

            if (response.status === 200) {
                const data = await response.json();
                console.log("A válasz tartalmazza a képek binárisait", data);

                return { success: true, response: data };
            } else {
                console.log("Nem lett OK státuszú:", response.status);

                return { success: false, response: null };
            }
        } catch (error) {
            console.error("Hiba történt a képek lekérése közben:", error);

            return { success: false, response: null };
        }
    },

    askPicture: async (gameToken, numberOfAskedPictures) => {
        try {
            const response = await fetch(`${API_URL}/game/ask/picture/number`, {
                method: "GET",
                headers: {
                    'gameToken': gameToken,
                    'numberOfAskedPictures': numberOfAskedPictures
                }
            });

            if (response.status === 200) {
                const data = await response.json();
                console.log("A válasz tartalmazza a képek binárisait", data);

                return { success: true, response: data };
            } else {
                console.log("Nem lett OK státuszú:", response.status);

                return { success: false, response: null };
            }
        } catch (error) {
            console.error("Hiba történt a képek lekérése közben:", error);

            return { success: false, response: null };
        }
    }
};

export default AuthService;
