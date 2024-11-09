use std::process::Command;
pub fn say_something(words:&str) {
    let status = Command::new("say")
        .arg(words)
        .status() // Execute the command and wait for it to finish
        .expect("failed to execute process");
        ;
    if status.success() {
        println!("done");
    } else {
        println!("failed");
    }
}
