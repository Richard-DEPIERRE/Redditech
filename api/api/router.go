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

	router.GET("/get/subreddits", getSubreddits)

	return router
}