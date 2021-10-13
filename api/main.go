package main

import (
	"strconv"

	"github.com/ClementBolin/redditech/api"
	"github.com/ClementBolin/redditech/configs"
)

func main() {
	var config = &configs.Config{}
	router := api.SetupRouter()

	config.InitConfig("./configs/config.json")
	router.Run(":" + strconv.Itoa(config.Port))
}