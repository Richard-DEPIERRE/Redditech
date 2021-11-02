package api

import (
	"encoding/json"
	"io/ioutil"

	"github.com/gin-gonic/gin"
)

// /api/v1/user/username/trophies
// Get data about user
func aboutUserTrophies(c *gin.Context) {
	var body map[string]interface{}
	var bodyClient map[string]interface{}

	jsonData, _ := ioutil.ReadAll(c.Request.Body)
	json.Unmarshal(jsonData, &bodyClient)

	token := bodyClient["token"].(string)
	usr := bodyClient["usr"].(string)

	var request Request
	err := request.createRequest(
		"https://oauth.reddit.com/api/v1/user/" + usr + "/trophies",
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

// /user/username/about
func aboutUserAbout(c *gin.Context) {
	var body map[string]interface{}
	var bodyClient map[string]interface{}

	jsonData, _ := ioutil.ReadAll(c.Request.Body)
	json.Unmarshal(jsonData, &bodyClient)

	token := bodyClient["token"].(string)
	usr := bodyClient["usr"].(string)

	var request Request
	err := request.createRequest(
		"https://oauth.reddit.com/api/v1/user/" + usr + "/about",
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

func userOverview(c *gin.Context) {
	var body map[string]interface{}
	var bodyClient map[string]interface{}

	jsonData, _ := ioutil.ReadAll(c.Request.Body)
	json.Unmarshal(jsonData, &bodyClient)

	token := bodyClient["token"].(string)
	usr := bodyClient["usr"].(string)

	var request Request
	err := request.createRequest(
		"https://oauth.reddit.com/api/v1/user/" + usr + "/overview",
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

func userSubmit(c *gin.Context) {
	var body map[string]interface{}
	var bodyClient map[string]interface{}

	jsonData, _ := ioutil.ReadAll(c.Request.Body)
	json.Unmarshal(jsonData, &bodyClient)

	token := bodyClient["token"].(string)
	usr := bodyClient["usr"].(string)

	var request Request
	err := request.createRequest(
		"https://oauth.reddit.com/api/v1/user/" + usr + "/submitted",
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

func userComment(c *gin.Context) {
	var body map[string]interface{}
	var bodyClient map[string]interface{}

	jsonData, _ := ioutil.ReadAll(c.Request.Body)
	json.Unmarshal(jsonData, &bodyClient)

	token := bodyClient["token"].(string)
	usr := bodyClient["usr"].(string)

	var request Request
	err := request.createRequest(
		"https://oauth.reddit.com/api/v1/user/" + usr + "/comments",
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

func userHidden(c *gin.Context) {
	var body map[string]interface{}
	var bodyClient map[string]interface{}

	jsonData, _ := ioutil.ReadAll(c.Request.Body)
	json.Unmarshal(jsonData, &bodyClient)

	token := bodyClient["token"].(string)
	usr := bodyClient["usr"].(string)

	var request Request
	err := request.createRequest(
		"https://oauth.reddit.com/api/v1/user/" + usr + "/hidden",
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