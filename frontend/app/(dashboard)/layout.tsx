import NavBar from "./components/navbar";
import Menu from "./components/menu";

export default function DashboardLayout({
  children, // will be a page or nested layout
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="drawer lg:drawer-open">
      <input id="my-drawer-2" type="checkbox" className="drawer-toggle" />
      <div className="drawer-content flex flex-col bg-base-200">
        <NavBar />
        <main className="p-2 bg-base-200">
          {children}
        </main>

      </div> 
      <div className="drawer-side border-r-2">
        <label htmlFor="my-drawer-2" className="drawer-overlay"></label> 
        <Menu />
      </div>
    </div>
 
  );
}