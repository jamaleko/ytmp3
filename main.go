package main

import (
	"fmt"
	"net/http"
	"os/exec"
)

func handler(w http.ResponseWriter, r *http.Request) {

	url := r.URL.Query().Get("url")

	if url == "" {
		fmt.Fprintln(w, "Masukkan ?url=youtube_link")
		return
	}

	cmd := exec.Command(
		"yt-dlp",
		"-x",
		"--audio-format", "mp3",
		url,
	)

	output, err := cmd.CombinedOutput()

	if err != nil {
		w.Write([]byte(err.Error()))
		return
	}

	w.Write(output)
}

func main() {

	http.HandleFunc("/", handler)

	fmt.Println("RUNNING")

	http.ListenAndServe(":10000", nil)
}