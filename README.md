# os

Hobby OS implementation in Rust

## Local development

### Docker

1. Build OS binary to `./target` directory:

    ```bash
    docker run --rm -it -v $(pwd)/target:/builder/target $(docker build -q .)
    ```

1. Boot OS using [QEMU](https://www.qemu.org/):

    ```bash
    qemu-system-x86_64 -drive format=raw,file=target/x86_64-os/debug/bootimage-os.bin
    ```

### Host system

1. Install dependencies

    ```bash
    cargo install bootimage
    rustup component add rust-src --toolchain nightly-aarch64-unknown-linux-gnu
    rustup component add llvm-tools-preview
    ```

1. Build OS binary to `./target` directory:

    ```bash
    cargo bootimage
    ```

1. Boot OS using [QEMU](https://www.qemu.org/):

    ```bash
    qemu-system-x86_64 -drive format=raw,file=target/x86_64-os/debug/bootimage-os.bin
    ```
