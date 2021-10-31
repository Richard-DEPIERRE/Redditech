package api

import (
	"encoding/json"
	"io"
	"io/ioutil"
	"log"
	"net/http"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
)

type bodyRequestSubreddits struct {
	Topic    string        `json:"topic"`
	Sort     string        `json:"sort"`
	SortType string        `json:"sort_type"`
	After    time.Duration `json:"after"`
	Before   time.Duration `json:"before"`
	Size     int           `json:"size"`
}

func getSubreddits(c *gin.Context) {
	var body = &bodyRequestSubreddits{}
	jsonData, err := io.ReadAll(c.Request.Body)
	if err != nil {
		c.JSON(400, &ErrorResponse{
			ErrorMessage: "Bad request",
		})
	}
	json.Unmarshal(jsonData, body)
	if body.Topic == "" || body.Size <= 0 {
		c.JSON(400, &ErrorResponse{
			ErrorMessage: "Bad request",
		})
	}
	resp, err := getSubredditsAPI(body)
	if err != nil {
		c.JSON(400, &ErrorResponse{
			ErrorMessage: "Bad request",
		})
	}
	m := map[string]interface{}{}
	json.Unmarshal(resp, &m)
	log.Println(m)
	c.JSON(200, m)
}

func getSubredditsAPI(body *bodyRequestSubreddits) ([]byte, error) {
	var bodyData []byte
	resp, err := http.Get(
		"https://api.pushshift.io/reddit/search/submission/?subreddit=" + body.Topic + "&sort=desc&sort_type=created_utc&size=" + strconv.Itoa(body.Size),
	)
	if err != nil {
		return bodyData, err
	}
	defer resp.Body.Close()
	bodyData, _ = io.ReadAll(resp.Body)
	return bodyData, nil
}

// Get hot subreddits
func getHots(c *gin.Context) {
	var body map[string]interface{}
	var bodyClient map[string]interface{}

	jsonData, _ := ioutil.ReadAll(c.Request.Body)
	json.Unmarshal(jsonData, &bodyClient)

	token := bodyClient["token"].(string)

	var request Request
	err := request.createRequest(
		"https://oauth.reddit.com/hot",
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

// Get tendances
func getBests(c *gin.Context) {
	var body map[string]interface{}
	var bodyClient map[string]interface{}

	jsonData, _ := ioutil.ReadAll(c.Request.Body)
	json.Unmarshal(jsonData, &bodyClient)

	token := bodyClient["token"].(string)

	var request Request
	err := request.createRequest(
		"https://oauth.reddit.com/best",
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

// Get new subreddits
func getNews(c *gin.Context) {
	var body map[string]interface{}
	var bodyClient map[string]interface{}

	jsonData, _ := ioutil.ReadAll(c.Request.Body)
	json.Unmarshal(jsonData, &bodyClient)

	token := bodyClient["token"].(string)

	var request Request
	err := request.createRequest(
		"https://oauth.reddit.com/new",
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
