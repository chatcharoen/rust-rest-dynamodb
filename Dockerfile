FROM rust:1.46 as builder

WORKDIR /usr/src 

COPY ./ ./
RUN cargo build --release
RUN rm src/*.rs

FROM debian:buster-slim
ARG APP=/usr/src/app
RUN apt-get update && apt-get -y install ca-certificates libssl-dev && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/src/target/release/product-api .
EXPOSE 8000
CMD ["./product-api"]
