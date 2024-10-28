const TIMES = {
  minutes: 60,
  hours: 60 * 60,
  seconds: 1,
}

type Duration = keyof typeof TIMES

export const timer = (
  timeout: number,
  message: string,
  duration: Duration = "seconds",
) => {
  const sleepDuration = timeout * TIMES[duration]
  const proc = Bun.spawn(
    [
      "sh",
      "-c",
      `sleep ${sleepDuration.toString()} && echo '${message}' && say '${message}'`,
    ],
    { stdout: "inherit" },
  )
  proc.unref()
  return proc.pid
}
