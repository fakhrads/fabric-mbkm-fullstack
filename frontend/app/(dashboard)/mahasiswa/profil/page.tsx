'use client'
import React, { useState } from "react";
import Datepicker from "react-tailwindcss-datepicker"; 

const Page = () => {
  const [value, setValue] = useState({ 
    startDate: null ,
    endDate: null 
  }); 
  const handleValueChange = (newValue: any) => {
    console.log("newValue:", newValue); 
    setValue(newValue); 
  } 
  return (
      <div
        className="block rounded-lg bg-white p-6 shadow-[0_2px_15px_-3px_rgba(0,0,0,0.07),0_10px_20px_-2px_rgba(0,0,0,0.04)] dark:bg-base-200">
        <form>
          <div className="grid grid-cols-2 gap-4">
            <div className="form-control">
              <label className="label">
                <span className="label-text">Nomor Induk Mahasiswa</span>
              </label>
              <input type="text" placeholder="Type here" className="input input-bordered " />              
            </div>

            <div className="form-control">
              <label className="label">
                <span className="label-text">Nomor Induk Kependudukan</span>
              </label>
              <input type="text" placeholder="Type here" className="input input-bordered " />                
            </div>
          </div>

          <div className="form-control">
            <label className="label">
              <span className="label-text">Nama Lengkap</span>
            </label>
            <input type="text" placeholder="Type here" className="input input-bordered " />                
          </div>  

          <div className="form-control">
            <label className="label">
              <span className="label-text">Email Aktif</span>
            </label>
            <input type="text" placeholder="Type here" className="input input-bordered " />                
          </div>  

          <div className="form-control">
            <label className="label">
              <span className="label-text">Nama Wali</span>
            </label>
            <input type="text" placeholder="Type here" className="input input-bordered " />                
          </div>  

          <div className="form-control">
            <label className="label">
              <span className="label-text">Tempat Lahir</span>
            </label>
            <input type="text" placeholder="Type here" className="input input-bordered " />                
          </div>  

          <div className="form-control">
            <label className="label">
              <span className="label-text">Tanggal Lahir</span>
            </label>

            <Datepicker 
              useRange={false} 
              asSingle={true} 
              value={value} 
              onChange={handleValueChange} 
              showShortcuts={true} 
            />             
          </div>        
          <div className="form-control mt-4">             
            <button
              type="submit"
              className="btn btn-primary"
              data-te-ripple-init
              data-te-ripple-color="light">
              Sign up
            </button>
          </div>
        </form>
      </div>
  )
}

export default Page