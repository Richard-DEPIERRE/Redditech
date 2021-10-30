package tests

import (
	"bytes"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"redditech/api"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestAuthMiddleware(t *testing.T) {
	router := api.SetupRouter()

	t.Run("should return 401 if no token is provided", func(t *testing.T) {
		var bodyTest map[string]interface{}
		w := httptest.NewRecorder()
		req, err := http.NewRequest("POST", "/", nil)

		if err != nil {
			t.Errorf("Error creating request: %v", err)
		}

		router.ServeHTTP(w, req)

		json.Unmarshal(w.Body.Bytes(), &bodyTest)
		assert.Equal(t, "empty body", bodyTest["error"])
		assert.Equal(t, http.StatusUnauthorized, w.Code)
		assert.Equal(t, float64(401), bodyTest["code"])
	})

	t.Run("should return pong message if token is provided", func(t *testing.T) {
		requestBody, _ := json.Marshal(map[string]interface{}{"token": "test"})
		w := httptest.NewRecorder()
		req, err := http.NewRequest("POST", "/test/middleware", bytes.NewBuffer(requestBody))

		if err != nil {
			t.Errorf("Error creating request: %v", err)
		}

		router.ServeHTTP(w, req)

		assert.Equal(t, http.StatusOK, w.Code)
		assert.Equal(t, "Request was authorized", w.Body.String())
	})
}