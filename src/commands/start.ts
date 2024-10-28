import { Args, Command, Flags } from "@oclif/core"
import { starter, type Config } from "../start"
import { timer } from "../timer"

export default class Start extends Command {
  static override args = {
    session_timeout: Args.string({
      description:
        "The amount of time to give each participant in the session. Defaults to 15 minutes",
    }),
  }

  static override description = "Start a new mobby-ing session"

  static override examples = ["<%= config.bin %> <%= command.id %>"]

  static override flags = {}

  public async run(): Promise<void> {
    const { args, flags } = await this.parse(Start)

    const timeout = args.session_timeout || "15"

    const config: Config = { timeout: parseInt(timeout) }
    const thisTimer = (message: string) =>
      timer(config.timeout, message, "minutes")
    const start = starter({ timer: thisTimer })
    const session = start(timeout)

    Bun.spawn(["cowsay", "Go Driver, Go!"])

    console.log("Session started!", session.timer?.pid)
  }
}
