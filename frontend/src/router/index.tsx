import { useRoutes } from 'react-router-dom'
import LandingPage from '../views/landing'

export default function Router() {
  return useRoutes([
    {
      path: '/',
      element: <LandingPage />,
    },
  ])
}