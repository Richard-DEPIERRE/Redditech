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
	router.Use(AuthMiddleware)
	router.POST("/test/middleware", func(c *gin.Context) {
		c.String(http.StatusOK, "Request was authorized")
	})
	// profile routes
	router.GET("/get/me", aboutMe)
	router.GET("/get/me/friends", getFriends)
	router.GET("/get/me/trophies", getTrophies)
	// subreddit routes
	router.GET("/get/suberredit/list", getListSubreddit)
	router.GET("/get/suberredit/about", getSuberedditAbout)
	// Action API
	router.POST("/action/suberredit/follow")

	return router
}