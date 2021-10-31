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

### Reddit api routes documentation

#### Search suberrit api:
**Basic reddit url**
```
https://oauth.reddit.com/
```

[useful link](https://pipedream.com/new?h=eyJ2IjoxLCJjIjpbInNfcjZuQ0JyIixbImFfNjdpbWIwIl1dfQ)

**Search subberit topic**
```
https://api.pushshift.io/reddit/search/submission/?subreddit=learnpython&sort=desc&sort_type=created_utc&after=1523588521&before=1523934121&size=1000
```
**params:**
```
subreddit=TOPIC
sort=desc (by default)
sort_type=created_utc (by default)
after=TIMESTAMP (optional)
before=TIMESTAMP (optional)
size=NUMBER (number of data in array)
```

## How to build and install Front

##### With flutter in terminal :

```bash
cd client
```

```bash
flutter pub get
```

```bash
flutter run
```
