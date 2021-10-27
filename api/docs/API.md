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

**url**: ```localhost:8080/get/subreddits```
**body request:**
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
---
**About me**

url: ```localhost:8080/get/me```
**body request:**
```json
{
  "token": "ACCESS_TOKEN",
}
```
**Response example:**
```
{

}
```

---
**Get list subreddit with name**

url: ```localhost:8080/get/suberredit/list```
**body request:**
```json
{
  "subreddit": "r/SUBREDDIT_NAME",
}
```
**Response example:**
```
{

}
```

---
**Get informations about a subreddit**

url: ```localhost:8080/get/me```
**body request:**
```json
{
  "subreddit": "r/SUBREDDIT_NAME",
}
```
**Response example:**
```
{

}
```
