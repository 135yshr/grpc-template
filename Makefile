.PHONY: build test clean static_analysis lint vet fmt docker

### コマンドの定義
GO          = go
GO_BUILD    = $(GO) build
GO_FORMAT   = $(GO) fmt
GO_TOOL		= $(GO) tool
GOFMT       = gofmt
GO_LIST     = $(GO) list
GOLINT      = golint
GO_TEST     = $(GO) test
GO_VET      = $(GO) vet
GO_CLEAN	= $(GO) clean
GO_GENERATE	= $(GO) generate
GO_INSTALL	= $(GO) install
GO_LDFLAGS  = -ldflags="-s -w"
GOOS        ?= linux
GOARCH		?= amd64

DOCKER_COMPOSE = docker compose -f deployments/docker-compose.yml

### ターゲットパラメータ
EXECUTABLES = bin/helloworld
TARGETS     = $(EXECUTABLES)
GO_PKGROOT  = ./...
GO_PACKAGES = $(shell $(GO_LIST) $(GO_PKGROOT) | grep -v vendor)
GO_TEST_TARGETS = $(shell $(GO_LIST) $(GO_PKGROOT) | grep -v main$$)

OUT_DIR		= out/
COVER_DIR	= $(OUT_DIR)cover/
COVER_FILE	= $(COVER_DIR)cover.out
COVER_HTML	= $(COVER_DIR)cover.html

### PHONY ターゲットのビルドルール
prepare:
	@cp githooks/* .git/hooks/
	@chmod +x .git/hooks/*
tools:
	$(GO_INSTALL) github.com/golang/mock/mockgen
	$(GO_INSTALL) google.golang.org/protobuf/cmd/protoc-gen-go@v1.26
	$(GO_INSTALL) google.golang.org/grpc/cmd/protoc-gen-go-grpc@1.1

build:
	$(GO_BUILD) $(GO_LDFLAGS) -o $(EXECUTABLES) cmd/app/main.go
clean:
	$(GO_CLEAN)
	rm -rf bin/*
	rm -rf $(OUT_DIR)
gen:
	@scripts/protoc.sh

test:
	@mkdir -p $(COVER_DIR)
	$(GO_TEST) -cover $(GO_TEST_TARGETS) -coverprofile=$(COVER_FILE)
	$(GO_TOOL) cover -html=$(COVER_FILE) -o $(COVER_HTML)

static_analysis: fmt lint vet

lint:
	$(GOLINT) $(GO_PACKAGES)
vet:
	$(GO_VET) $(GO_PACKAGES)
fmt:
	$(GO_FORMAT) $(GO_PKGROOT)

build-docker:
	$(DOCKER_COMPOSE) build --no-cache --force-rm
up:
	$(DOCKER_COMPOSE) up -d
stop:
	$(DOCKER_COMPOSE) stop
down:
	$(DOCKER_COMPOSE) down --remove-orphans
restart:
	@make down
	@make up
destroy:
	$(DOCKER_COMPOSE) down --rmi all --volumes --remove-orphans
destroy-volumes:
	$(DOCKER_COMPOSE) down --volumes --remove-orphans
ps:
	$(DOCKER_COMPOSE) ps
logs:
	$(DOCKER_COMPOSE) logs
logs-watch:
	$(DOCKER_COMPOSE) logs --follow
log-db:
	$(DOCKER_COMPOSE) logs db
log-db-watch:
	$(DOCKER_COMPOSE) logs --follow db
