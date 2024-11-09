use std::process::Command;
use clap::{App, Arg};

pub mod os_interaction;

fn main() {
    let matches = App::new("git-custom")
        .version("1.0")
        .author("Your Name")
        .about("Custom Git porcelain command")
        .arg(Arg::new("action")
            .help("Action to perform")
            .required(true)
            .index(1))
        .get_matches();

    let action = matches.value_of("action").unwrap();

    match action {
        "status" => git_status(),
        "commit" => git_commit(),
        "say" =>  os_interaction::say::say_something("Welcome to mobby"),
        // Add more actions as needed
        _ => println!("Unknown action: {}", action),
    }
}
fn git_status() {
    let output = Command::new("git")
        .arg("status")
        .arg("--porcelain")
        .output()
        .expect("Failed to execute git status");

    if output.status.success() {
        let status = String::from_utf8_lossy(&output.stdout);
        if status.is_empty() {
            println!("Working directory clean");
        } else {
            println!("Changes detected:\n{}", status);
        }
    } else {
        eprintln!("Error: {}", String::from_utf8_lossy(&output.stderr));
    }
}

fn git_commit() {
    // Implement commit logic here
    println!("Commit functionality not yet implemented");
}
