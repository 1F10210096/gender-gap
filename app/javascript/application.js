// Entry point for the build script in your package.json
import React from 'react';
import { createRoot } from 'react-dom/client';
import { App } from './react/App.tsx';

const container = document.getElementById('root');
console.log(container)
if (container) {
  const root = createRoot(container);
//   console.log(root)
  document.addEventListener('DOMContentLoaded', () => {
    root.render(<App />);
  });
}