package main

import (
	"os"

	"github.com/troubling/hummingbird/internal/nectar"
)

func main() {
	nectar.CLI(os.Args, nil, nil, nil)
}
