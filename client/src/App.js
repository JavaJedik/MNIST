import React from 'react';
import './App.css';
import Login from './components/login';
import Home from './components/home';
import Register from './components/register';
import Leaderboard from './components/leaderboard';
import Game from './components/game';
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
            <Route path="/game" element={<Game />} />
        </Routes>
      </BrowserRouter>
  );
}

export default App;
