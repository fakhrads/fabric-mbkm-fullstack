const Hero = () => {
  return (
      <div className="mx-auto max-w-[540px] sm:max-w-[604px] md:max-w-[720px] lg:max-w-[972px] xl:max-w-full xl:px-12 2xl:max-w-[1400px]">
        <div className="mt-[200px] text-center">
          <div className="mb-4 flex items-center justify-center text-[40px] font-medium dark:text-neutral-100">
            <picture>
              <source srcSet="
            https://tecdn.b-cdn.net/img/logo/te-transparent-noshadows.webp
          " type="image/webp" />
              <img src="https://tecdn.b-cdn.net/img/logo/te-transparent-noshadows.png" className="mb-1 mr-4 h-[35px]" alt="logo" />
            </picture>
            Tailwind Elements
          </div>
          <a href="https://tailwind-elements.com/" data-te-ripple-init data-te-ripple-color="light" target="_blank" className="inline-block rounded bg-primary px-6 pb-2 pt-2.5 text-xs font-medium uppercase leading-normal text-white shadow-[0_4px_9px_-4px_#3b71ca] transition duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]">
            Check docs
          </a>
        </div>
      </div>
  )
}

export default Hero;