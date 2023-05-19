# (Semi-serious) Idea Machine

Web app that creates ChatGPT-generated ideas for the digitalization of Berlin. The ideas are explicitly semi-serious and are intended as a conversation starter. The ideas are generated from physical die rolls that emit their result side and POST it to the web app. Each side is associated with a term such as "App", "Bäume", etc. that serves as input to the idea generation.

> This app is a Ruby on Rails application.

## Open todo's

- [x] Setup resources for dice/sides/etc.
- [x] Create UI that always shows latest die rolls
- [x] Document POSTing via JSON
- [ ] Setup GitHub action CI (including tests and linting)
- [ ] Add code quality and security tooling (SimpleCov, Brakeman, etc.)
- [ ] Enable creation of ideas via button press (from ChatGPT)
- [ ] Streamline flow between idea creation and return to die roll view
- [ ] (Enbale printing result to paper)

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
  -H "Content-type: application/json" \
  -X POST \
  -d ' {"roll":{"shortcode": "C1"}}' \
  http://localhost:3000/rolls
```

The important bit is the shortcode payload that is sent. As of now, we have agreed that all dice emit their result via a mapping of A-C for the die and 1-6 for the result side. This means that currently the shortcodes `A{1-6}`, `B{1-6}`, and `C{1-6}` are valid. All other combinations will be rejected by the app.

> Note that it is not necessary to include a timestamp in the request body as the timestamp is set on the application server.

## Development

### Tests

We use Rails' built-in Minitest. Run all test via

```bash
bin/rails test
```

### Developing with Tailwind

If you want to make changes to usage of TailwindCSS, please use the script that not only starts up the Rails server, but also a separate process for watching Tailwind:

```bash
bin/dev
```

The app will be available at http://localhost:3000
