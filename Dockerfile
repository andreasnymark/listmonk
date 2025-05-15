# Stage 1: Build the Listmonk binary with embedded templates
FROM golang:1.21-alpine AS builder

# Install build tools
RUN apk add --no-cache make

WORKDIR /listmonk
COPY . .

# Build the binary with embedded templates/assets
RUN make build

# Stage 2: Create lightweight final runtime image
FROM alpine:latest

WORKDIR /listmonk

# Copy the compiled binary
COPY --from=builder /listmonk/listmonk .

# Copy your config
COPY config.toml .

# Copy the static folder so --static-dir can use it at runtime
COPY static/ ./static

# Run listmonk with your config
CMD ["./listmonk"]