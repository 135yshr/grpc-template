# gRPC project Teample

## DEMO

TBD

## Features

TBD

## Requirement

- [Go 1.16+](https://golang.org)
- [protoc](http://google.github.io/proto-lens/installing-protoc.html)
- [direnv](https://direnv.net/)

## Installation

### Tools

- [Go](https://golang.org/doc/install)
- [protoc](http://google.github.io/proto-lens/installing-protoc.html)
- [direnv](https://direnv.net/docs/installation.html)

### Develop environment

```bash
git clone http://github.com/135yshr/grpc-template.git
cd grpc-template
make prepare
make tools
make build
```

### Add proto file

1. Add the proto file to the `api/proto/v1` directory
   - Can also create subdirectories
2. Execute the `make gen` command
3. A `pb.go` is created in the `pkg/api/v1` directory

## Usage

TBD

## Note

### Container structure

```
├── app
└── db
```

#### app container

- Base image
  - [alpine:latest](https://hub.docker.com/_/alpine)

#### db container

- Base image
  - [mysql:8.0](https://hub.docker.com/_/mysql)

## License

Distributed under the MIT License. See [LICENSE](https://github.com/135yshr/grpc-template/blob/main/LICENSE) for more information.

## Author

- [@135yshr](https://twitter.com/135yshr) (isago@oreha.dev)
