import React from 'react';
import './App.css';
import Login from './components/login';
import Home from './components/home';
import Register from './components/register';
import Leaderboard from './components/leaderboard';
import Number_Game from './components/number_game';
import Picture_Game from './components/picture_game';
import Admin from './components/admin';
import {BrowserRouter, Navigate, Route, Routes} from "react-router-dom";
function App() {
    return (
        <BrowserRouter>
        <Routes>
            <Route path="/" element={<Navigate to="/login"/>}/>
            <Route path="/login" element={<Login />} />
            <Route path="/home" element={<Home />} />
            <Route path="/register" element={<Register />} />
            <Route path="/leaderboard" element={<Leaderboard />} />
            <Route path="/number_game" element={<Number_Game />} />
            <Route path="/picture_game" element={<Picture_Game />} />
            <Route path="/admin" element={<Admin />} />
        </Routes>
      </BrowserRouter>
  );
}

export default App;
