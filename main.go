package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq" // registers postgres drivers
)

var (
	db *sql.DB
)

type Artist struct {
	id   int
	name string
}

func Init() {
	var err error

	connStr := fmt.Sprintf("host=35.236.63.213 user=public-user password=lakerswin2020 dbname=music_catalog sslmode=disable")
	db, err = sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}

	if err := db.Ping(); err != nil {
		log.Fatal(err)
	}
}

func ArtistsHandler(w http.ResponseWriter, r *http.Request) {
	//vars := mux.Vars(r)
	//
	//println(vars)

	rows, err := db.Query("SELECT id, name FROM artists")
	if err != nil {
		log.Fatal(err)
	}

	defer func() {
		_ = rows.Close()
	}()

	for rows.Next() {
		var artist Artist
		if err := rows.Scan(&artist.id, &artist.name); err != nil {
			log.Fatal(err)
		}
		_, _ = w.Write([]byte(fmt.Sprintf("ID: %d --- Name: %s\n", artist.id, artist.name)))
	}
}

func main() {

	Init()

	defer func() {
		_ = db.Close()
	}()

	r := mux.NewRouter()

	r.HandleFunc("/artists", ArtistsHandler)
	log.Fatal(http.ListenAndServe("localhost:8080", r))
}
