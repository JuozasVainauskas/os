// don't link the Rust standard library
#![no_std]

// disable all Rust-level entry points
#![no_main]

// Tests related features
#![feature(custom_test_frameworks)]
#![test_runner(os::test_runner)]
#![reexport_test_harness_main = "test_main"]

use core::panic::PanicInfo;
use os::println;

// Disable name mangling
// To ensure that the Rust compiler really outputs a function with the name _start.
// Without the attribute, the compiler would generate some cryptic _ZN3blog_os4_start7hb173fedf945531caE symbol
// extern "C" uses C calling convention
#[unsafe(no_mangle)]
pub extern "C" fn _start() -> ! {
    // this function is the entry point, since the linker looks for a function
    // named `_start` by default

    println!("System booted successfully");

    os::init();

    #[cfg(test)]
    test_main();

    os::hlt_loop();
}

// This function is called on panic in non-test mode.
#[cfg(not(test))] // new attribute
#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    println!("{}", info);
    os::hlt_loop();
}

#[cfg(test)]
#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    os::test_panic_handler(info)
}

#[test_case]
fn trivial_assertion() {
    assert_eq!(1, 1);
}
