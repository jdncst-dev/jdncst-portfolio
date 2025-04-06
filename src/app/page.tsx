import { ExternalLink } from 'lucide-react'
import Link from 'next/link'

export default function Home() {
  return (
    <>
      <main className='flex flex-col items-center justify-center min-h-screen py-2 px-2'>
        <h1 className='text-3xl font-bold'>Jordan Castiglioni</h1>
        <h2 className='text-2xl font-bold mb-4'>Full Stack Developer</h2>
        <p className='text-xl mb-4'>Work In Progress</p>
        <div className='flex flex-col items-center gap-2'>
          <Link
            className='text-md flex gap-2 items-center'
            href='https://www.linkedin.com/in/jordan-castiglioni/'
            target='blank'
          >
            LinkedIn
            <ExternalLink size={16} />
          </Link>
          <Link
            className='text-md flex gap-2 items-center'
            href='https://github.com/jdncst-dev/'
            target='blank'
          >
            Github
            <ExternalLink size={16} />
          </Link>
        </div>
      </main>
    </>
  )
}
