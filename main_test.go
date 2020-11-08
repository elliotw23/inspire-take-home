package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/gorilla/mux"
)

func TestGetArtists(t *testing.T) {
	makeRequest := func(req *http.Request) []Artist {
		rr := httptest.NewRecorder()
		handler := http.HandlerFunc(GetArtistsHandler)

		handler.ServeHTTP(rr, req)

		fmt.Println(rr.Code)
		fmt.Println(rr.Body)

		body, _ := ioutil.ReadAll(rr.Body)

		artists := &[]Artist{}

		err := json.Unmarshal(body, artists)
		if err != nil {
			log.Fatal("Unexpected response type")
		}

		return *artists
	}

	// Test returning all artists
	noFilterReq := httptest.NewRequest("GET", "/artists", nil)
	noFilterResp := makeRequest(noFilterReq)
	if len(noFilterResp) < 5 {
		log.Fatal("Expecting at least 5 artists")
	}

	// Test filtering by id
	idFilterReq := httptest.NewRequest("GET", "/artists", nil)
	idFilterReq = mux.SetURLVars(idFilterReq, map[string]string{"id": "1"})
	fmt.Println(mux.Vars(idFilterReq))
	fmt.Println(idFilterReq.URL.String())
	idFilterResp := makeRequest(idFilterReq)

	if len(idFilterResp) != 1 {
		log.Fatal("Expected only 1 artist")
	}
	if idFilterResp[0].ID != 1 {
		log.Fatal("Incorrect artist returned")
	}
}

// TODO add TestGetAlbums

// TODO add tests for inserting artists and albums (requires a test db)
