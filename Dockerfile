FROM golang:1.25 AS build
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN make hummingbird

FROM debian:bookworm-slim
RUN apt update && apt install -y memcached sqlite3 tar xfsprogs && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /var/cache/swift /var/log/hummingbird /var/run/hummingbird /var/local/hummingbird
COPY --from=build /src/bin/hummingbird /bin/hummingbird
CMD ["/bin/hummingbird", "--help"]