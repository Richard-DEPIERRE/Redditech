# REDDITECH

## How to build API

##### With docker :

Start by running the docker daemon and build the image with the following command:

```bash
cd ./api && docker build -t redditech .
```

and run your image with: 

```bash
docker run -it --rm redditech
```

##### Without docker :

Verify [go](https://golang.org/dl/) (version 1.17) is installed on your machine.
After that, you can build and run your API with the following commands:

```bash
cd ./api && go build -o api && ./api
```