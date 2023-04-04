use fehler::*;

#[throws(i32)]
fn main() {
    foo(true)?;
    println!("Hello, world!");


    
}

#[throws(i32)]
fn foo(x: bool) -> i32 {
    if x {
        0
    } else {
        throw!(1);
    }
}
