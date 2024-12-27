FROM golang:alpine AS builder

RUN apk add --no-cache upx

WORKDIR /app

RUN go mod init fullcycle && go mod tidy

COPY main.go .

RUN go build -ldflags="-s -w" -o fullcycle && upx --best fullcycle

FROM scratch

COPY --from=builder /app/fullcycle /fullcycle

ENTRYPOINT ["/fullcycle"]