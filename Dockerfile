FROM rust:1.73-slim-bullseye

WORKDIR /builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends qemu-system=1:5.2+dfsg-11+deb11u3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./.cargo ./.cargo
COPY ./src ./src
COPY ./Cargo.toml .
COPY ./Cargo.lock .
COPY ./rust-toolchain.toml .
COPY ./x86_64-os.json .
COPY ./tests ./tests

RUN cargo install bootimage && \
    rustup toolchain install nightly-aarch64-unknown-linux-gnu && \
    rustup toolchain install nightly-x86_64-unknown-linux-gnu && \
    rustup component add rust-src --toolchain nightly-aarch64-unknown-linux-gnu && \
    rustup component add rust-src --toolchain nightly-x86_64-unknown-linux-gnu && \
    rustup component add llvm-tools-preview

CMD ["cargo","bootimage"]
