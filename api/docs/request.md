# Request object

This object is a basic encaptulation of the http library. it allows you to create a request with different arguments, like a token, a body, an http request type and of course a url.

##### How to use

```go
  var request Request

  err := request.createRequest(
    "https://oauth.reddit.com/api/v1/me",
    "GET",
    body,
    token,
  )
```

the ```createRequest``` method take many arguments for design your request and return an error object. it is equal to ```nil``` if no error has been thrown.

```go
func (r *Request) createRequest(
	url string,
	reqType string,
	body map[string]interface{},
	token string,
) error {}
```

###### How to send a request

```go
func (r *Request) sendRequest() (map[string]interface{}, error)
```

You must call this function once your query object has been created and filled with your different values. Once this function is called, the request is sent to the provided url and it returns a ```map[string]interface{}``` with the content of the received response
it is equal to nil if no error has been thrown 

#### Request type available

**PUT**
**DELETE**
**POST**
**GET**
**UPDATE**

#### Full example

```go
func aboutMe(c *gin.Context) {
  var body map[string]interface{}
  var bodyClient map[string]interface{}

  jsonData, _ := ioutil.ReadAll(c.Request.Body)
  json.Unmarshal(jsonData, &bodyClient)

  token := bodyClient["token"].(string)

  var request Request
  err := request.createRequest(
    "https://oauth.reddit.com/api/v1/me",
    "GET",
    body,
    token,
  )
  if err != nil {
    c.JSON(401, &ErrorResponse{
      ErrorMessage: err.Error(),
      Code:         403,
    })
  }
  resp, _ := request.sendRequest()
  c.JSON(200, resp)
}
```