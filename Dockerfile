# golang:latest as build-env
FROM golang:latest AS build-env

RUN mkdir /app
ADD . /app/
WORKDIR /app
RUN cd /app && GO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o myapp .
# go build -o myapp

FROM scratch
COPY --from=build-env /app/myapp .

# Expose port 8888 to the outside world
EXPOSE 8888

# Command to run the executable
CMD ["./main"]
