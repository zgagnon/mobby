export interface Config {
  timeout: number
}

export type PID = number

export interface Collaborators {
  timer: (message: string) => PID
}

interface Session {
  active: boolean
  timer?: { pid: PID }
}

const starterMessage = (timeout: string) =>
  `Timer started. You have ${timeout} minutes. Go Driver, Go!`

export const starter =
  ({ timer }: Collaborators) =>
  (timeout: string) => {
    const timerPid = timer(starterMessage(timeout))

    return { active: true, timer: { pid: timerPid } }
  }
