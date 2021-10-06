FROM golang:1.17

LABEL mainter="clement.bolin@epitech.eu" project="Redditech"

WORKDIR /api

COPY . .

RUN go build -o api

CMD ["./api"]
