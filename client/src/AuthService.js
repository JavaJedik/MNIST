import {changer} from "./components/changer";

const API_URL = 'https://mnist-server.serveo.net';

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

            return await response.json();

            if (response.status === 200) {
                const responseText = await response.text();
                console.log('Válasz típusa:', typeof responseText);
                console.log('Válasz tartalma:', responseText);
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

    sendPicture: (userToken, pic, picture_answer_answer, picture_answer_type, probability) => {
        let breakFunction = false

        if (!pic) {
            alert("Please select a file before uploading.");
            breakFunction = true;
        }
        if(picture_answer_answer === '') {
            alert("Please declare the answer for the picture.");
            breakFunction = true;
        }
        if(breakFunction) {
            return;
        }

        console.log("Kép betöltése sikeres!");
        console.log("Az elküldött kép byte tömbje: ", pic)
        console.log("Az elküldött válasz: ", picture_answer_answer)

        const pictureAnswerObject = [
            {
                picture_answer_type,
                picture_answer_answer,
                probability
            }
        ];

        console.log(typeof pictureAnswerObject)
        console.log(pic.length)

        /*let alma = JSON.stringify(pictureAnswerObject)
        console.log(typeof alma)*/

        fetch(`${API_URL}/upload/picture`, {
            method: "POST",
            headers: {
                'userToken': `${userToken}`,
                'pictureAnswers': `${JSON.stringify(pictureAnswerObject)}`
            },
            body: pic
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
    },

    checkForGameToken: async (userToken) => {
        const response = await fetch(`${API_URL}/askToken/gameToken`, {
            method: "GET",
            headers: {
                'userToken': `${userToken}`,
            },
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

    checkGameToken: (gameToken) => {
        fetch(`${API_URL}/game/ask/picture/number`, {
            method: "GET",
            headers: {
                'gameToken': `${gameToken}`,
            },
        })
        .then((response) => {
            console.log(response.text());
            if(response.ok) {
                console.log("ok státuszú lett");
            } else {
                console.log("nem lett ok státuszú");
            }
        })
    }
};
export default AuthService;