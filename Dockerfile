FROM rust:1.73-slim-bullseye

WORKDIR /builder

COPY ./.cargo ./.cargo
COPY ./src ./src
COPY ./Cargo.toml .
COPY ./Cargo.lock .
COPY ./rust-toolchain.toml .
COPY ./x86_64-os.json .

RUN cargo install bootimage && \
    rustup component add rust-src --toolchain nightly-aarch64-unknown-linux-gnu && \
    rustup component add llvm-tools-preview

CMD ["cargo","bootimage"]
