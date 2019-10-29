FROM golang

RUN go get github.com/revel/revel
RUN go get github.com/revel/cmd/revel
RUN revel new app

COPY ./ /go/src/app/

EXPOSE 9000

CMD [ "revel", "run", "-a", "app" ]
