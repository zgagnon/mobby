import { describe, expect, it, mock } from "bun:test"
import { starter } from "."

const NOOP = () => {}

describe("Mob session start", () => {
  it("should start a mob session", () => {
    const timer = () => 4
    const start = starter({ timer, message: NOOP })
    const session = start({ timeout: 10 })
    expect(session.active).toBe(true)
  })

  it("starts a timer", () => {
    const timer = mock(() => 4)
    const start = starter({ timer, message: NOOP })
    const session = start({ timeout: 10 })
    expect(timer).toHaveBeenCalledWith(10)
  })

  it("returns the timer PID", () => {
    const timer = mock(() => 4)
    const start = starter({ timer, message: NOOP })
    const session = start({ timeout: 10 })
    expect(session.timer?.pid).toBe(4)
  })

  it("prints a message", () => {
    const timer = () => 4
    const message = mock(NOOP)
    const start = starter({ timer, message })
    const session = start({ timeout: 10 })
    expect(message).toHaveBeenCalledWith(
      "Timer started. You have 10 minutes. Go Driver, Go!",
    )
  })
})
