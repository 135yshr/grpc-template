FROM golang:1.16 as builder
LABEL maintainer="135yshr <isago@oreha.dev>"

EXPOSE 9000

RUN mkdir /app
ADD . /app/
WORKDIR /app
RUN make build

FROM alpine:latest as importer
RUN apk --no-cache add ca-certificates tzdata
WORKDIR /root/
COPY --from=builder /app/bin/helloworld .

CMD ["./helloworld"]
