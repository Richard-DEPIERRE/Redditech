package api

import (
	"github.com/gin-gonic/gin"
)

type bodyFied struct {
	Token string `json:"access_token"`
	SubName []string `json:"subreddit"`
}

// Send array with fieds of the user
func GetNewsFied(c *gin.Context) {
	
}
