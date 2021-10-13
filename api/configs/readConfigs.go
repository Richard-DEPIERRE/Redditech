package configs

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"
)

type Config struct {
	Port        int    `json:"port"`
	ClientId    string `json:"clientId"`
	SecretToken string `json:"secretToken"`
}

func (obj *Config) InitConfig(path string) {
	jsonFile, err := os.Open(path)

	if err != nil {
		log.Fatalln(err)
	}
	defer jsonFile.Close()
	byteValue, _ := ioutil.ReadAll(jsonFile)
	json.Unmarshal(byteValue, &obj)
}

func (obj *Config) ReadConfig() {
	fmt.Println(obj)
}
