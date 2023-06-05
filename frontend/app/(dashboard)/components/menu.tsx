import Link from 'next/link';
import { navLinks } from '../../config/menu'

const NavBar = () => {
  return(
    <ul className="menu p-4 w-80 h-full bg-base-100 text-base-content">
      <li className='py-4'>
        <div className="text-lg font-bold p-4 py-4 bg-slate-200">
            <div className="avatar online placeholder">
              <div className="bg-neutral-focus text-neutral-content rounded-full w-14">
                <span className="text-xl">JO</span>
              </div>
            </div> 
            <div className=''>
              <p className="text-gray-700 text-lg font-medium">Fakhri!</p>
              <p className="text-gray-500 text-sm font-normal">Admin</p>            
            </div>
          </div>
      </li>
      {navLinks.map((item, index) => {
        if (item.level === 'admin') {
          return (
            <li >
              <Link className='py-2'href={item.path}>
                {item.name}
              </Link>
            </li>
          );
        }
      })}
    </ul>
  )
}

export default NavBar;