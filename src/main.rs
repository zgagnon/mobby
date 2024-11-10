use clap::{arg, Command};

pub mod os_interaction;

fn cli<'a>() -> Command<'a> {
     Command::new("mobby")
        .version("1.0")
        .author("Zell")
        .about("Ensemble programming code coordination via Git")
        .arg_required_else_help(true)
        .subcommand_required(true)
        .subcommand(
            Command::new("timer")
                .about("Set a timer with a message")
                .arg(arg!(<TIME> "The time to wait"))
                .arg(arg!(<MESSAGE> "The message to send")
                )
        )
}

fn main() {
    let matches = cli().get_matches();
    match matches.subcommand() {
        Some((sub, _)) => {
            println!("Called with {sub:?}");

        }
        _ => unreachable!(),
    };
}
