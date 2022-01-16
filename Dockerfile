# Build image.
FROM golang:1.17-bullseye as build

WORKDIR /go/src/app

COPY go.* ./
RUN go mod download

COPY . ./
RUN --mount=type=cache,target=/root/.cache/go-build make linux

# Distroless is a lightweight base image.
FROM gcr.io/distroless/base-debian11
COPY --from=build /go/src/app/k8sensor /
CMD ["/k8sensor"]