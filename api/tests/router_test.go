package tests

import (
	"log"
	"net/http"
	"net/http/httptest"
	"testing"

	"redditech/api"
	"github.com/stretchr/testify/assert"
)

func TestRouterHome(t *testing.T) {
	router := api.SetupRouter()

	w := httptest.NewRecorder()
	req, err := http.NewRequest("GET", "/", nil)
	if err != nil {
		log.Fatalln(err)
	}
	router.ServeHTTP(w, req)

	assert.Equal(t, http.StatusOK, w.Code, "Test http code from \"/\" route")
	assert.Equal(t, "Welcome to Redditech API", w.Body.String())
}