package tests

import (
	"redditech/api"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestCreateRequest(t *testing.T) {
	t.Run("should return an error, because invalid method", func(t *testing.T) {
		_, err := api.CreateRequestTest(
			"https://github.com/",
			"INVALID",
			nil,
			"TOKEN",
		)
		assert.Nil(t, err)
	})

	t.Run("should create valid request", func(t *testing.T) {
		_, err := api.CreateRequestTest(
			"localhost:8080/get",
			"GET",
			nil,
			"TOKEN",
		)
		assert.Nil(t, err)
	})
}

func TestSendRequest(t *testing.T) {
	t.Run("should send valid request", func(t *testing.T) {
		req, err := api.CreateRequestTest(
			"https://github.com/",
			"GET",
			nil,
			"TOKEN",
		)
		assert.Nil(t, err)
		body, err := api.SendRequestTest(req)
		assert.Nil(t, err)
		assert.Nil(t, body)
	})
}