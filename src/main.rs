use std::path::PathBuf;

use clap::Parser;
use failure::{bail, ensure, Error};
use fehler::*;
use rexif;
use walkdir::WalkDir;

#[derive(Parser)]
struct Args {
    dir: PathBuf,
}

#[throws]
fn main() {
    let args = Args::parse();
    for f in WalkDir::new(args.dir) {
        println!("Hello, world!");
    }
}
