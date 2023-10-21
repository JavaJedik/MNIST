const API_URL = 'http://localhost:8814'; //'https://mnist-server.serveo.net';

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
      const response = await fetch(`${API_URL}/login`, {
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

  checkLoggedIn: async () => {
    const userToken = localStorage.getItem('userToken');

    try {
      const response = await fetch(`${API_URL}/check-logged-in`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          userToken
        })
      });

      return await response.json();
    } catch (error) {
      console.error('Fetch error:', error);
      throw new Error('Token check failed');
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
  }
};
export default AuthService;