package api

import (
	"encoding/json"
	"io/ioutil"

	"github.com/gin-gonic/gin"
)

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
