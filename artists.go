package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"log"
	"net/http"
	"strconv"
)

type Artist struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

/*
Method = GET
Parameters:
	id: 0 for all, prioritized before name if not 0
	name: will match on any non-empty string
*/
func GetArtistsHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, _ := strconv.Atoi(vars["id"])
	name, _ := vars["name"]

	log.Printf("GET artists request received")

	queryStr := `SELECT id, name FROM artists`
	if id != 0 {
		queryStr += fmt.Sprintf(` WHERE id = %d`, id)
	} else if name != "" {
		queryStr += fmt.Sprintf(` WHERE name ILIKE '%%%s%%'`, name)
	}

	rows, err := db.Query(queryStr)
	if err != nil {
		writeError(err, w)
		return
	}

	defer func() {
		_ = rows.Close()
	}()

	var resp []Artist

	for rows.Next() {
		var artist Artist
		if err := rows.Scan(&artist.ID, &artist.Name); err != nil {
			writeError(err, w)
		}
		resp = append(resp, artist)
	}

	writeResponse(resp, w)
}

/*
Method = POST
Parameters:
	name: string
*/
func PostArtistHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	name := vars["name"]

	log.Printf("POST artists request received: name = %s", name)

	result, err := db.Exec("INSERT INTO artists (name) VALUES ($1)", name)
	if err != nil {
		writeError(err, w)
		return
	}

	if row, _ := result.RowsAffected(); row != 1 {
		writeError(fmt.Errorf("error creating new artist"), w)
	}
}
