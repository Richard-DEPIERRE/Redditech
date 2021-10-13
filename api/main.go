package main

import (
	"strconv"

	"redditech/api"
	"redditech/configs"
)

func main() {
	var config = &configs.Config{}
	router := api.SetupRouter()

	config.InitConfig("./configs/config.json")
	router.Run(":" + strconv.Itoa(config.Port))
}