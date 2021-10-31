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
	router.GET("/get/blocked", getBlocked)
	router.GET("/get/messages", getMessaging)
	// subreddit routes
	router.GET("/get/suberredit/list", getListSubreddit)
	router.GET("/get/suberredit/about", getSuberedditAbout)
	router.GET("get/new", getNews)
	router.GET("get/hot", getHots)
	router.GET("get/best", getBests)
	// Action API
	router.POST("/action/suberredit/follow")
	// Uer API
	router.GET("/user/trophies", aboutUserTrophies)
	router.GET("/user/about", aboutUserAbout)
	router.GET("/user/submit", userSubmit)
	router.GET("/user/overview", userOverview)
	router.GET("/user/comment", userComment)
	router.GET("/user/hidden", userHidden)

	return router
}