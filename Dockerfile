# syntax=docker/dockerfile:1

##
## Build
##
FROM golang:1.18-buster AS build

WORKDIR /app

COPY go.mod ./
RUN go mod download

# make it find all files
COPY *.go ./

RUN go build -o /assistant-bot

##
## Deploy
##
FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /assistant-bot /assistant-bot

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/assistant-bot"]
