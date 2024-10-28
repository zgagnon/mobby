import { describe, expect, it, mock } from "bun:test"
import { timer } from "."

describe("The timer", () => {
  it("should start a cli timer", () => {
    const pid = timer(1, "timer test passed!", "seconds")
    console.log("PID", pid)
    expect(pid).not.toBe(4)
  })
})
