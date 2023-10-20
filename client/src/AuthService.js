const API_URL = 'https://mnist-server.serveo.net';

const AuthService = {
    
  login: async (username, password) => {
    try {
      const response = await fetch(`${API_URL}/login`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          username,
          password
        })
      });

      const data = await response.json();

      if (data.success) {
        localStorage.setItem('userToken', data.userToken);
      }

      return data;
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
  }
};

export default AuthService;
