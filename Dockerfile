FROM arm64v8/golang:1.16 as build

RUN apt update -y && apt install -y git dmsetup

ENV VERSION "v0.45.0"

RUN git clone --branch ${VERSION} https://github.com/google/cadvisor.git /go/src/github.com/google/cadvisor

WORKDIR /go/src/github.com/google/cadvisor

RUN make build

FROM arm64v8/debian

COPY --from=build /go/src/github.com/google/cadvisor/cadvisor /usr/bin/cadvisor

EXPOSE 8080

ENTRYPOINT ["/usr/bin/cadvisor", "-logtostderr"]
