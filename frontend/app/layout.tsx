import './globals.css'
import { Inter } from 'next/font/google'
import Providers from "./providers";

const inter = Inter({ subsets: ['latin'] })

export const metadata = {
  title: 'UNIKOM MBKM with Blockchain',
  description: 'Aplikasi Rekognisi MBKM dengan Blockchain',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html data-theme="light" lang="en">
      <body className={inter.className}>
        <Providers>
          {children}
        </Providers>
      </body>
    </html>
  )
}
