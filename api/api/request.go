package api

import (
	"bytes"
	"encoding/json"
	"io/ioutil"
	"net/http"
)

type Request struct {
	url     string
	reqType string
	body    map[string]interface{}
	token   string
	request *http.Request
	client  *http.Client
}

func (r *Request) createRequest(
	url string,
	reqType string,
	body map[string]interface{},
	token string,
) error {
	var errReq error
	r.url = url
	r.reqType = reqType
	r.body = body
	r.token = token
	r.client = &http.Client{}
	bodyData, err := json.Marshal(body)

	if err != nil {
		return err
	}
	r.request, errReq = http.NewRequest(reqType, url, bytes.NewBuffer(bodyData))
	r.request.Header.Set("User-Agent", "Redditech_Epitech/1.0")
	if errReq != nil {
		return errReq
	}
	r.request.Header.Add("Authorization", "Bearer "+token)
	return nil
}

func (r *Request) sendRequest() (map[string]interface{}, error) {
	var bodyJson map[string]interface{}
	resp, err := r.client.Do(r.request)

	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()
	bodyResp, errResp := ioutil.ReadAll(resp.Body)
	if errResp != nil {
		return bodyJson, errResp
	}
	json.Unmarshal(bodyResp, &bodyJson)
	return bodyJson, nil
}
