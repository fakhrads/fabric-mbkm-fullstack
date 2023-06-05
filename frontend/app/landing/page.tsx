import Image from 'next/image'
import {
  LoginButton,
  LogoutButton,
  ProfileButton,
  RegisterButton,
} from "fakhrads/app/components/button";

export default function Home() {
  return (
    <main
      style={{
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
        height: "70vh",
      }}
    >
      <div>
        <LoginButton />
        <RegisterButton />
        <LogoutButton />
        <ProfileButton />
      </div>
    </main>
  )
}
