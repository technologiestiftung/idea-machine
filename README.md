# (Semi-serious) Idea Machine

Web app that creates ChatGPT-generated ideas for the digitalization of Berlin. The ideas are explicitly semi-serious and are intended as a conversation starter. The ideas are generated from physical die rolls that emit their result side and POST it to the web app. Each side is associated with a term such as "App", "Bäume", etc. that serves as input to the idea generation.

> This app is a Ruby on Rails application.

## Open todo's

- [x] Setup resources for dice/sides/etc.
- [x] Create UI that always shows latest die rolls
- [x] Document POSTing via JSON
- [ ] Setup GitHub action CI (including tests and linting)
- [x] Add code quality and security tooling (SimpleCov, Brakeman, etc.)
- [x] Enable creation of ideas via button press (from ChatGPT)
- [x] Streamline flow between idea creation and return to die roll view
- [ ] Enbale printing result to paper
- [x] Consider protecting JSON endpoint with simple auth check
- [x] Protect everything with simple HTTP Auth
- [x] save associated rolls with idea
- [ ] Style UI
- [ ] Animate arrival of new rolls

## Requirements

- Ruby version as defined in `.ruby-version`
- SQLite3
- Redis

## Getting started

In order to set this app up, follow these steps:

Install dependencies:

```bash
bundle install
```

Create the database:

```bash
bin/rails db:create && bin/rails db:migrate
```

Seed the database with the dice and sides and keywords:

```bash
bin/rails db:seed
```

Spin up the Rails server:

```bash
bin/rails s
```

The app will be available at http://localhost:3000

You can now POST your dice roll results like so:

```bash
curl \
  -H "Accept: application/json" \
  -H "Content-type: application/x-www-form-urlencoded" \
  -H "Authorization: Bearer TOKEN-YOU-SET-IN-CREDENTIALS" \
  -X POST \
  -d 'shortcode=C3' \
  http://localhost:3000/api/v1/rolls
```

The important bit is the shortcode payload that is sent. As of now, we have agreed that all dice emit their result via a mapping of A-C for the die and 1-6 for the result side. This means that currently the shortcodes `A{1-6}`, `B{1-6}`, and `C{1-6}` are valid. All other combinations will be rejected by the app.

> Note that it is not necessary to include a timestamp in the request body as the timestamp is set on the application server.

## Development

### Tests

We use Rails' built-in Minitest. Run all test via

```bash
bin/rails test
```

Easch test run collects the current test coverage. Inspect it via `open coverage/index.html`. There is currently no minimum coverage required.

### Developing with Tailwind

If you want to make changes to usage of TailwindCSS, please use the script that not only starts up the Rails server, but also a separate process for watching Tailwind:

```bash
bin/dev
```

The app will be available at http://localhost:3000

## Deployment

This app is primarily developed for a local exhibition context. It is therefore likely to be deployed locally on a Raspberyy Pi.

However, for testing and debugging reasons, we also deploy an instance to Fly.io.

Follow their [docs for deploying a Rails app](https://fly.io/docs/rails/getting-started/existing/) and for [using SQLite3](https://fly.io/docs/rails/advanced-guides/sqlite3/) as a database.

Once the app is deployed to Fly, we currently manually ran `fly ssh console -C "/rails/bin/rails db:seed"` to seed the database with the initial dice data.
