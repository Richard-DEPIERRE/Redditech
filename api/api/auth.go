package api

import (
	"bytes"
	"encoding/json"
	"io/ioutil"

	"github.com/gin-gonic/gin"
)

func AuthMiddleware(c *gin.Context) {
	var body map[string]interface{}

	if c.Request.Body != nil {
		jsonData, _ := ioutil.ReadAll(c.Request.Body)
		json.Unmarshal(jsonData, &body)
		c.Request.Body = ioutil.NopCloser(bytes.NewBuffer(jsonData))
		if body["token"] == "" {
			c.JSON(401, &ErrorResponse{
				ErrorMessage: "invalid token",
				Code: 401,
			})
			return
		}
	} else {
		c.JSON(401, &ErrorResponse{
			ErrorMessage: "empty body",
			Code: 401,
		})
		return
	}
	c.Next()
}