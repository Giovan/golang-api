# golang:latest as build-env
FROM golang:latest AS build-env

RUN mkdir /app
ADD . /app/
WORKDIR /app

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
# RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY . .

# Build the Go app
RUN go build -o main .

FROM scratch
COPY --from=build-env /app .

# Expose port 8888 to the outside world
EXPOSE 8888

# Command to run the executable
CMD ["./main"]
