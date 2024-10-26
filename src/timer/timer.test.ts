import { describe, expect, it, mock } from "bun:test"

const TIMES = {
  minutes: 60,
  hours: 60 * 60,
  seconds: 1,
}

type Duration = keyof typeof TIMES

const timer = (
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

describe("The timer", () => {
  it("should start a cli timer", () => {
    const pid = timer(1, "timer test passed!", "seconds")
    console.log("PID", pid)
    expect(pid).not.toBe(4)
  })
})
