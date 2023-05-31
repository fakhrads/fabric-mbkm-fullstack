import { render } from 'preact'
import { BrowserRouter } from "react-router-dom";
import { App } from './app.tsx'
import './index.css'

render(
  <BrowserRouter basename={import.meta.env.VITE_PUBLIC_PATH as string}>
    <App />
  </BrowserRouter>, 
  document.getElementById('app') as HTMLElement
)
