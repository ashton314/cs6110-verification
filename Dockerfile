FROM debian

# Base packages
RUN apt-get update && apt-get upgrade --yes
RUN apt-get install wget curl make git z3 opam --yes

# OCaml configuration
RUN opam init
RUN opam pin add why3 https://gitlab.inria.fr/why3/why3.git
RUN opam pin add why3-ide https://gitlab.inria.fr/why3/why3.git
RUN opam install lablgtk3 lablgtk3-sourceview3 ocamlgraph why3 why3-ide

# Configure Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

# Install Creusot
RUN git clone https://github.com/xldenis/creusot

WORKDIR creusot
