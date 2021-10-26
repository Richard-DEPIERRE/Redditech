# API documentation

### Authorization

All differents routes need to adds some basic data to the query body request. **All requests need to have body in json format**

```json
{
  "token": "ACCESS_TOKEN",
  ...
}
```

You can get your **access_token** with the reddit API. [follow this link for more information about access token and reddit](https://github.com/reddit-archive/reddit/wiki/OAuth2).

### GET Request

**Search subberedit topic:**
body: 
```json
{
  "topic": "TOPIC_SEARCH",
  "size": "NUMBER_OF_ITEMS_EXPECT",
}
```
response example:
```json
    "data": [
        {
            "all_awardings": [],
            "allow_live_comments": false,
            "author": "Hilmaryngvi",
            "author_flair_css_class": null,
            "author_flair_richtext": [],
            ...
        },
        ...
```