package main

import (
	"log"
	"os"

	"github.com/pocketbase/pocketbase"
	"github.com/pocketbase/pocketbase/apis"
	"github.com/pocketbase/pocketbase/core"
)

// main is the entry point for the PocketBase fork.
// It initializes the application, registers any custom hooks or routes,
// and starts the server.
func main() {
	app := pocketbase.New()

	// Register a custom "before serve" hook to add any additional
	// routes or middleware before the default PocketBase routes are loaded.
	app.OnBeforeServe().Add(func(e *core.ServeEvent) error {
		// Register a simple health-check endpoint.
		e.Router.GET("/_health", func(c apis.ApiFunc) error {
			return c.JSON(200, map[string]string{
				"status": "ok",
			})
		})

		return nil
	})

	// Start the application; arguments are read from os.Args by default.
	// Using log.Fatal instead of manual log+exit for cleaner error handling.
	if err := app.Start(); err != nil {
		log.Fatal(err)
	}
}
