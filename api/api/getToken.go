package api

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

type bodyToken struct {
	Code string `json:"code"`
}

type responseToken struct {
	Message string `json:"message"`
	Error   string `json:"error"`
	Token   string `json:"token"`
}

func sendRedditLoginRequest(code string) {
	req, err := http.NewRequest(
		"https://www.reddit.com/api/v1/access_token?grant_type=authorization_code&code="+code+"&redirect_uri=http://localhost:8080/ping/get_access_token",
		"application/json",
		nil,
	)
	req.Header.Add("Authorization", "Basic " + base64.StdEncoding.EncodeToString([]byte(":")))
	if err != nil {
		log.Fatalln(err)
	}
	defer req.Body.Close()
	body, _ := io.ReadAll(req.Body)
	fmt.Println("Body response:", string(body))
}

func getToken(c *gin.Context) {
	var body = &bodyToken{}
	jsonData, err := io.ReadAll(c.Request.Body)
	if err != nil {
		log.Fatalln(err)
	}
	// Fill struct
	json.Unmarshal(jsonData, body)
	// Check strict is fill
	if body.Code == "" {
		c.JSON(401, &responseToken{
			Message: "",
			Error:   "Code body field is empty or does not exit",
			Token:   "",
		})
		return
	}
	sendRedditLoginRequest(body.Code)
}

func getAccessToken(c *gin.Context) {
	type redditRes struct {
		AccessToken  string `json:"access_token"`
		TokenType    string `json:"token_type"`
		ExpireIn     string `json:"expires_in"`
		Scope        string `json:"scope"`
		RefreshToken string `json:"refresh_token"`
	}
	var res = &redditRes{}
	jsonData, err := io.ReadAll(c.Request.Body)
	if err != nil {
		log.Fatalln(err)
	}
	// Fill res struct
	json.Unmarshal(jsonData, res)
	log.Println(res)
}
