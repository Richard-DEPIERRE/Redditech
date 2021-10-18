package api

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func SetupRouter() *gin.Engine {
	router := gin.Default()

	// Standard route
	router.GET("/", func(c *gin.Context) {
		c.String(http.StatusOK, "Welcome to Redditech API")
	})

	router.GET("/get/r/fieds", GetNewsFied)
	router.POST("/get/access_token", getToken)
	router.POST("/ping/get_access_token", getAccessToken)
	router.GET("/get/subreddits", getSubreddits)

	return router
}