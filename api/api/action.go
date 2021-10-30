package api

import (
	"encoding/json"
	"fmt"
	"io/ioutil"

	"github.com/gin-gonic/gin"
)

func followSubreddit(c *gin.Context) {
	var body map[string]interface{}
	var bodyClient map[string]interface{}

	jsonData, _ := ioutil.ReadAll(c.Request.Body)
	json.Unmarshal(jsonData, &bodyClient)

	token := bodyClient["token"].(string)
	follow := bodyClient["follow"].(bool)
	fullname := bodyClient["fullname"].(string)

	json.Marshal(body)

	var request Request
	err := request.createRequest(
		"https://oauth.reddit.com/api/follow_post?follow=" + fmt.Sprint(follow) + "&fullname=" + fullname,
		"POST",
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