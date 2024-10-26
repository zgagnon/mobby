export interface Config {
  timeout: number
}

export type PID = number

export interface Collaborators {
  timer: (timeout: number) => PID
  message: (text: string) => void
}

interface Session {
  active: boolean
  timer?: { pid: PID }
}

const starterMessage = (timeout: number) =>
  `Timer started. You have ${timeout} minutes. Go Driver, Go!`

export const starter =
  ({ timer, message }: Collaborators) =>
  (config: Config): Session => {
    const timerPid = timer(config.timeout)

    message(starterMessage(config.timeout))

    return { active: true, timer: { pid: timerPid } }
  }
