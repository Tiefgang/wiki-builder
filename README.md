# Wiki builder

This repository is only for techies.

It's main purpose is to have a easy and convenient workflow of building and serving the wiki.

This is mainly used by our server operators.

## Usage

- `just build` Build the static files for serving with a http server.
- `just serve` Spin up the local development server.
- `just setup` Install dependencies.
- `just clone` Clone the actual wiki repo and put the wiki files into this project folder.

## Troubleshooting

If you're experiencing any issues but it worked before, run a `just clean`.

This kills the Python virtual environment, pulls the newest dependencies and rebuilds everything.

## Requirements

- A Github account with proper pull permissions
- Linux
- [`just`](https://github.com/casey/just)
- A modern Python 3
