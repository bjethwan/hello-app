FROM golang:1.8-alpine
ADD . /go/src/hello-app
RUN go install hello-app
COPY /go/bin/hello-app .
ENV PORT 8080
CMD ["./hello-app"]
