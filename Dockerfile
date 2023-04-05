FROM debian

# Base packages
RUN apt-get update && apt-get upgrade --yes
RUN apt-get install wget curl make git z3 opam autoconf pkg-config --yes

# OCaml configuration
RUN opam init --disable-sandboxing --yes
RUN eval $(opam env)
RUN opam switch create 4.14.1
RUN eval $(opam env)
RUN opam pin add why3 https://gitlab.inria.fr/why3/why3.git --yes
RUN eval $(opam env)
# RUN opam pin add why3-ide https://gitlab.inria.fr/why3/why3.git --yes
# RUN eval $(opam env)
RUN opam install ocamlgraph why3 --yes
# RUN opam install lablgtk3 lablgtk3-sourceview3 ocamlgraph why3 why3-ide --yes
# RUN eval $(opam env)

# Configure Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

# Install Creusot
RUN git clone --depth 1 https://github.com/xldenis/creusot
WORKDIR creusot
RUN /root/.cargo/bin/cargo install --path creusot

# Install CreuSAT
WORKDIR /
RUN git clone --depth 1 https://github.com/sarsko/CreuSAT.git
WORKDIR CreuSAT
RUN cargo build
RUN cargo install --force cargo-make
