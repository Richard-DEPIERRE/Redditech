package api

type ErrorResponse struct {
	ErrorMessage string `json:"error"`
	Code         int    `json:"code"`
}
