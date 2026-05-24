# Stage 1: Build the Go binary
FROM golang:1.22-alpine AS builder

# Install build dependencies
RUN apk add --no-cache gcc musl-dev

WORKDIR /app

# Copy go module files first for better layer caching
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the source code
COPY . .

# Build the binary with CGO enabled (required for SQLite)
RUN CGO_ENABLED=1 GOOS=linux go build \
    -ldflags='-w -s -extldflags "-static"' \
    -o pocketbase \
    main.go

# Stage 2: Create a minimal runtime image
FROM alpine:3.19

# Install ca-certificates for HTTPS and tzdata for timezone support
RUN apk add --no-cache ca-certificates tzdata

# Create a non-root user for security
RUN addgroup -S pbgroup && adduser -S pbuser -G pbgroup

WORKDIR /pb

# Copy the binary from the builder stage
COPY --from=builder /app/pocketbase /pb/pocketbase

# Ensure the binary is executable
RUN chmod +x /pb/pocketbase

# Create the data directory and set ownership
RUN mkdir -p /pb/pb_data /pb/pb_migrations /pb/pb_hooks && \
    chown -R pbuser:pbgroup /pb

# Switch to non-root user
USER pbuser

# Expose the default PocketBase port
EXPOSE 8090

# Persist data directory as a volume
VOLUME ["/pb/pb_data"]

# Default command: serve on all interfaces
ENTRYPOINT ["/pb/pocketbase"]
CMD ["serve", "--http=0.0.0.0:8090", "--dir=/pb/pb_data"]
