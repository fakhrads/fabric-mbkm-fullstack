import { useState } from 'preact/hooks'
import HomeStyle from './index.module.scss'
import { useNavigate } from 'react-router-dom'
import Hero from './components/hero'
import Header from './components/header'

const publicPath = import.meta.env.VITE_PUBLIC_PATH

function LandingPage() {
  const [count, setCount] = useState(0)
  const navigate = useNavigate()
  const goAboutPage = () => {
    navigate('/about')
  }

  return (
    <>
      <header className="mb-14">
        <Header />
      </header>

      <main>
        <div>
          <Hero />
        </div>
      </main>

      <footer>

      </footer>
    </>
  )
}

export default LandingPage