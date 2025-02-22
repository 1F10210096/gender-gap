import React from 'react'
import { BrowserRouter as Router } from 'react-router-dom'
import { AppRoutes } from './AppRoutes'

export const App: React.FC = () => {
  return (
    <Router>
      <AppRoutes />
    </Router>
  )
}