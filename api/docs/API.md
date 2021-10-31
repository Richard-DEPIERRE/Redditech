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
#### About me

url: ```localhost:8080/get/me```
body request:
```json
{
  "token": "ACCESS_TOKEN",
}
```
Response example:
```json
{
    "me":
        {
            "all_awardings": [],
            "allow_live_comments": false,
            "pseudo": "Hilmaryngvi",
            "author_flair_css_class": null,
            "author_flair_richtext": [],
            "trophies": 12,
            ...
        }
        ...
}
```

#### About my friends

**url: ```localhost:8080/get/me/friends```**
body request:
```json
{
  "token": "ACCESS_TOKEN",
}
```
Response example:
```json
{
    "me":
        {
            "bthpseudo": 1122439898,
            "pseudo": "ps",
            "subreddit": [ "list subreddit" ]
            ...
        }
        ...
}
```

#### Get blocked

**url: ```localhost:8080/get/blocked``**
body request:
```json
{
  "token": "ACCESS_TOKEN",
}
```
Response example:
```json
{
    "me":
        {
            "bthpseudo": 1122439898,
            "pseudo": "ps",
            "blocTime": 123355
            ...
        }
        ...
}
```

#### Get messages

**url: ```localhost:8080/get/messages```**
body request:
```json
{
  "token": "ACCESS_TOKEN",
  "id": "PSEUDO"
}
```
Response example:
```json
{
    "me":
        {
            "bthpseudo": 1122439898,
            "pseudo": "ps",
            "messages": [
              {
                "content": "messages",
                "time": 178636744,
              },
              ...
            ]
            ...
        }
        ...
}
```

#### About my trophies

url: ```localhost:8080/get/me/trophies```
body request:
```json
{
  "token": "ACCESS_TOKEN",
}
```
Response example:
```json
{
    "me":
        {
            "lists": [ "TROPHIES" ],
            "trophies": 12,
            ...
        }
        ...
}
```

---

#### Get list subreddit with name

url: ```localhost:8080/get/suberredit/list```
body request:
```json
{
  "subreddit": "r/SUBREDDIT_NAME",
}
```
Response example:
```json
{
    "kind": "string", 
    "data": {
        "modhash": "string", 
        "dist": int, 
        "children": [{
            "kind": "string", 
            "data": {
                "approved_at_utc":"string", 
                "subreddit": "string", 
                "selftext": "string" 
                ...,
                "is_video":"boolean"
            }],
        "after":"",
        "before:""
    }
}
```

#### Get informations about a subreddit

**url: ```localhost:8080/get/suberredit```**
body request:
```json
{
  "subreddit": "r/SUBREDDIT_NAME",
}
```
Response example:
```json
{
    "kind": "string", 
    "data": {
        "modhash": "string", 
        "dist": int, 
        "children": [{
            "kind": "string", 
            "data": {
                "approved_at_utc":"string", 
                "subreddit": "string", 
                "selftext": "string" 
                ...,
                "is_video":"boolean"
            }],
        "after":"",
        "before:""
    }
}
```

**url: ```localhost:8080/get/suberredit/about```**
body request:
```json
{
  "subreddit": "r/SUBREDDIT_NAME",
}
```
Response example:
```json
{
    "kind": "string", 
    "data": {
        "modhash": "string", 
        "dist": int, 
        "kind": "string", 
        "approved_at_utc":"string", 
        "subreddit": "string", 
        "selftext": "string" 
        "is_video":"boolean"          
        "after":"",
        "before:"",
        ...,
    }
}
```

**url: ```localhost:8080/get/new```**
body request:
```json
{
  "subreddit": "r/SUBREDDIT_NAME",
  "size": "LIST_SIZE"
}
```
Response example:
```json
{
    "kind": "string", 
    "data": {
        "modhash": "string", 
        "dist": int, 
        "children": [
            {
              "kind": "string", 
              "data": {
                  "approved_at_utc":"string", 
                  "subreddit": "string", 
                  "selftext": "string" 
                  ...,
                  "is_video":"boolean"
              }
            },
            {
              "kind": "string", 
              "data": {
                  "approved_at_utc":"string", 
                  "subreddit": "string", 
                  "selftext": "string" 
                  ...,
                  "is_video":"boolean"
              }
            },
            {
              "kind": "string", 
              "data": {
                  "approved_at_utc":"string", 
                  "subreddit": "string", 
                  "selftext": "string" 
                  ...,
                  "is_video":"boolean"
              }
            },
            {
              "kind": "string", 
              "data": {
                  "approved_at_utc":"string", 
                  "subreddit": "string", 
                  "selftext": "string" 
                  ...,
                  "is_video":"boolean"
              }
            },
            ...
          ],
        "after":"",
        "before:""
    }
}
```

**url: ```localhost:8080/get/hot```**
body request:
```json
{
  "subreddit": "r/SUBREDDIT_NAME",
  "size": "LIST_SIZE"
}
```
Response example:
```json
{
    "kind": "string", 
    "data": {
        "modhash": "string", 
        "dist": int, 
        "children": [
            {
              "kind": "string", 
              "data": {
                  "approved_at_utc":"string", 
                  "subreddit": "string", 
                  "selftext": "string" 
                  ...,
                  "is_video":"boolean"
              }
            },
            {
              "kind": "string", 
              "data": {
                  "approved_at_utc":"string", 
                  "subreddit": "string", 
                  "selftext": "string" 
                  ...,
                  "is_video":"boolean"
              }
            },
            {
              "kind": "string", 
              "data": {
                  "approved_at_utc":"string", 
                  "subreddit": "string", 
                  "selftext": "string" 
                  ...,
                  "is_video":"boolean"
              }
            },
            {
              "kind": "string", 
              "data": {
                  "approved_at_utc":"string", 
                  "subreddit": "string", 
                  "selftext": "string" 
                  ...,
                  "is_video":"boolean"
              }
            },
            ...
          ],
        "after":"",
        "before:""
    }
}
```

**url: ```localhost:8080/get/best```**
body request:
```json
{
  "subreddit": "r/SUBREDDIT_NAME",
  "size": "LIST_SIZE"
}
```
Response example:
```json
{
    "kind": "string", 
    "data": {
        "modhash": "string", 
        "dist": int, 
        "children": [
            {
              "kind": "string", 
              "data": {
                  "approved_at_utc":"string", 
                  "subreddit": "string", 
                  "selftext": "string" 
                  ...,
                  "is_video":"boolean"
              }
            },
            {
              "kind": "string", 
              "data": {
                  "approved_at_utc":"string", 
                  "subreddit": "string", 
                  "selftext": "string" 
                  ...,
                  "is_video":"boolean"
              }
            },
            {
              "kind": "string", 
              "data": {
                  "approved_at_utc":"string", 
                  "subreddit": "string", 
                  "selftext": "string" 
                  ...,
                  "is_video":"boolean"
              }
            },
            {
              "kind": "string", 
              "data": {
                  "approved_at_utc":"string", 
                  "subreddit": "string", 
                  "selftext": "string" 
                  ...,
                  "is_video":"boolean"
              }
            },
            ...
          ],
        "after":"",
        "before:""
    }
}
```

#### follow subreddit
**url: ```localhost:8080/get/blocked``**
body request:
```json
{
  "token": "ACCESS_TOKEN",
  "subID: "ID"
}
```
Response example:
```json
{
  "status": "valid or error
}
```
