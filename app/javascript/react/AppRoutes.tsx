import React from 'react';
import { Routes, Route } from 'react-router-dom';
import { Top } from './pages/Top';

export const AppRoutes = () => {
  return (
    <>
      <Routes>
        <Route path="/" element={<Top />} />
      </Routes>
    </>
  )
};