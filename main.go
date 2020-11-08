package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq" // registers postgres drivers
)

var (
	db *sql.DB
)

func init() {
	var err error

	// Connect to music_catalog postgresql database
	connStr := fmt.Sprintf("host=35.236.63.213 user=public-user password=lakerswin2020 dbname=music_catalog sslmode=disable")
	db, err = sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}

	if err := db.Ping(); err != nil {
		log.Fatal(err)
	}
}

func writeResponse(resp interface{}, w http.ResponseWriter) {
	w.Header().Set("Content-Type", "application/json")

	encoder := json.NewEncoder(w)

	_ = encoder.Encode(resp)
}

func writeError(err error, w http.ResponseWriter) {
	log.Printf("Error occurred: %s", err)
	// TODO don't directly return db error to client
	http.Error(w, err.Error(), 400)
}

func main() {

	defer func() {
		_ = db.Close()
	}()

	r := mux.NewRouter()

	// TODO use auto-generated api schema framework like protobuf
	r.HandleFunc("/artists", GetArtistsHandler).Methods("GET").Queries(
		"id", "{id:[0-9]+}", "name", "{name}")
	r.HandleFunc("/artists", PostArtistHandler).Methods("POST").Queries(
		"name", "{name}")
	r.HandleFunc("/albums", GetAlbumsHandler).Methods("GET").Queries(
		"id", "{id:[0-9]+}", "artist_id", "{artist_id:[0-9]+}", "artist_name", "{artist_name}", "title", "{title}",
		"order", "{order}")
	r.HandleFunc("/albums", PostAlbumHandler).Methods("POST").Queries(
		"artist_id", "{artist_id:[0-9]+}", "title", "{title}", "year", "{year:[0-9]+}",
		"record_condition", "{record_condition}", "thumbnail", "{thumbnail}",
	)
	log.Println("Starting Server on port 8080")
	log.Fatal(http.ListenAndServe("localhost:8080", r))
}
