package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"log"
	"net/http"
	"strconv"
)

type Album struct {
	ID              int    `json:"id"`
	Title           string `json:"title"`
	ArtistID        int    `json:"artist_id"`
	ArtistName      string `json:"artist_name"`
	Year            int    `json:"year"`
	RecordCondition string `json:"record_condition"`
	Thumbnail       string `json:"thumbnail"`
}

/*
Method = GET
Parameters:
	id: int   			(filter)
	artist_id: int 		(filter)
	title: string		(filter)
	artist_name			(filter)
	order: 				(sort)
		title
		artist
		year
*/
func GetAlbumsHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, _ := strconv.Atoi(vars["id"])
	artistId, _ := strconv.Atoi(vars["artist_id"])
	title := vars["title"]
	artistName := vars["artist_name"]
	order := vars["order"]

	log.Printf("GET albums request received")

	queryStr := `SELECT albums.id, artist_id, a.name, title, year, record_condition, thumbnail FROM albums 
    	JOIN artists a on a.id = albums.artist_id`
	if id != 0 {
		queryStr += fmt.Sprintf(` WHERE albums.id = %d`, id)
	} else if artistId != 0 {
		queryStr += fmt.Sprintf(` WHERE artist_id = %d`, artistId)
	} else if title != "" {
		queryStr += fmt.Sprintf(` WHERE title ILIKE '%%%s%%'`, title)
	} else if artistName != "" {
		queryStr += fmt.Sprintf(` WHERE a.name ILIKE '%%%s%%'`, artistName)
	}

	if order != "" {
		if order == "title" {
			queryStr += ` ORDER BY title`
		} else if order == "artist" {
			queryStr += ` ORDER BY a.name`
		} else if order == "year" {
			queryStr += ` ORDER BY year`
		} else {
			writeError(fmt.Errorf("invalid value '%s' given for 'order' argument", order), w)
			return
		}
	}

	rows, err := db.Query(queryStr)
	if err != nil {
		writeError(err, w)
		return
	}

	defer func() {
		_ = rows.Close()
	}()

	var resp []Album

	for rows.Next() {
		var album Album
		if err := rows.Scan(&album.ID, &album.ArtistID, &album.ArtistName, &album.Title, &album.Year,
			&album.RecordCondition, &album.Thumbnail); err != nil {
			writeError(err, w)
		}
		resp = append(resp, album)
	}

	writeResponse(resp, w)
}

/*
Method = POST
Parameters:
	artist_id: int
	title: string
	year: int
	recordCondition: string
	thumbnail: url string
*/
// TODO should include entering condition_id or enumerate record_condition
func PostAlbumHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	artistId, _ := strconv.Atoi(vars["artist_id"])
	title := vars["title"]
	year := vars["year"]
	recordCondition := vars["record_condition"]
	thumbnail := vars["thumbnail"]

	log.Printf("POST albums request received: artist_id = %d, title = %s", artistId, title)

	result, err := db.Exec(`INSERT INTO albums (artist_id, title, year, record_condition, thumbnail) 
		VALUES ($1, $2, $3, $4, $5)`, artistId, title, year, recordCondition, thumbnail)
	if err != nil {
		writeError(err, w)
		return
	}

	if row, _ := result.RowsAffected(); row != 1 {
		writeError(fmt.Errorf("error creating new album"), w)
		return
	}
}
