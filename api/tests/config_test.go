package configs_test

import (
	"testing"

	"github.com/redditech/configs"
	"github.com/stretchr/testify/assert"
)

func TestReadConfig(t *testing.T) {
	config := &configs.Config{}
	config.InitConfig("./test_config.json")
	assert.Equal(t, "CLIENT_ID", config.ClientId, "Test the value of clientId in the config file")
	assert.Equal(t, "SECRET_TOKEN", config.SecretToken, "Test the value of secretToken in the config file")
	assert.Equal(t, 8080, config.Port, "Test the value of port in the config file")
}
