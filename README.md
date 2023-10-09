# (Semi-serious) Idea Machine

Web app that creates ChatGPT-generated ideas for the digitalization of Berlin. The ideas are explicitly semi-serious and are intended as a conversation starter. The ideas are generated from physical die rolls that emit their result side and POST it to the web app. Each side is associated with a term such as "Web-App", "Gesundheit", etc. that serves as input to the idea generation.

![Technical setup of the app](/public/idea-machine-setup-v2.png)

![Physical setup of the project](/public/idea-machine-irl.png)

The app works in combination with the [code for the Arduino boards](https://github.com/technologiestiftung/idea-machine-dice/).

For every usage event of the physical dice, we create a new "game" in the app. You can create new games, along with all its required resources (dice, sides) like so:

```bash
bin/rails db:"create_game[lib/data/{FILENAME}.json]"
```

Make sure to use an existing filename when using this command.

> In the deployed app, you will need to login to the app machine first via `fly ssh console`.

Refer to `lib/data/` for the required structure of the JSON file.

We curate the possible roll values via a combination of dice and sides, as they are present in the database. Valid shortcodes to be posted are currently `A{1-6}`, `B{1-6}`, `C{1-6}`.

Each die has a "surprise" side, marked with a question tag. This side will pick a random term to be included in the idea generation prompt.

Also, some of the labels have a "shadow" label, which means that not the exact term is sent to the idea generation service, but a modified, more specific one.

## Requirements

- Ruby version as defined in `.ruby-version`
- SQLite3
- Redis

## Technical summary

In alignment with the [MVC pattern used in Rails](https://guides.rubyonrails.org/getting_started.html#mvc-and-you), we've modeled the app in the following way:

A `Game` has many dice (model `Die`). Each `Die` has many `Side`'s and each `Side` has a label associated with it. From the outside we POST `Roll`'s. Each `Roll` is associated with a `Side`. All this is saved in the database and represented in the `app/models` folder.

Of importance is also the realtime communication that happens over Rails' built-in Websockets integration ([example for integration in the `Roll` model](https://github.com/technologiestiftung/idea-machine/blob/b6bf472520411acb4e6d6e1f032e1f0d91e7eb10/app/models/roll.rb#L15)). This is necessary because the UI needs to react to each `Roll` and the form used for generating `Idea`'s is populated with the `Side`'s associated with the latest `Roll` for each `Die`.

The trigger for printing is done [on the JavaScript side](app/javascript/controllers/localhost_post_controller.js) because we need to interact with the printing server that is hosted on a Raspberry Pi that has the deployed Rails app opened in a browser.

## Development

### Credentials

We need a couple of credentials, e.g. for external services. These are stored in the built-in encrypted credentials file (`config/credentials.yml.enc`). You will need to add a local `config/master.key` in order to decrypt them. Find the key in our shared password vault.

In the test environment, we use a different credentials file with fake credentials in order to prevent using/leaking production credentials in test runs. The file can be found in `config/credentials/test.yml.enc` and the key should be set in `config/credentials/test.key`. You can find the test key in our shared password vault as well.

Edit credentials like so (example using nano editor):

Production/master credentials:

```bash
EDITOR=nano rails credentials:edit
```

Test credentials:

```bash
EDITOR=nano rails credentials:edit --environment test
```

### Tests

We use Rails' built-in Minitest. Run all test via

```bash
bin/rails test
```

Each test run collects the current test coverage. Inspect it via `open coverage/index.html`. There is currently no minimum coverage required.

#### Tests in CI

We have a GitHub Action set up that runs the tests (see `.github/workflows/rails.yml`).

### Developing with Tailwind

If you want to make changes to usage of TailwindCSS, please use the script that not only starts up the Rails server, but also a separate process for watching Tailwind:

```bash
bin/dev
```

The app will be available at http://localhost:3000

## Deployment

This app is deployed to [fly.io](https://fly.io).

> **Important**: The initial setup will most likely already be done, however we currently don't have a continuous deployment set up. You will need to manually run `fly deploy` for new dployments.

First, follow the [docs for deploying a Rails app](https://fly.io/docs/rails/getting-started/existing/) and for [using SQLite3](https://fly.io/docs/rails/advanced-guides/sqlite3/) as a database.

Once the app is deployed, you need to manually run `fly ssh console -C "/rails/bin/rails db:seed"` to seed the database with the initial dice data.

### Other useful commands

In the lifecycle of the app, you might find the following commands useful.

#### Restarting the app server

This has become necessary a few times, because the connection between the app and the Redis server had timed out.

```bash
fly apps restart idea-machine
```

> Replace `idea-machine` with your app name on Fly.

#### Scaling your app server

```bash
fly scale vm shared-cpu-2x
```

> Replace `shared-cpu-2x` with your desired size.

#### Extending/scaling the SQLite3 volume

```bash
flyctl volumes extend vol_1234
```

> Replace `vol_1234` with the name of the actual volume.

Always refer to the [fly.io API reference](https://fly.io/docs/reference/) for the latest version of all these commands.

## Interacting with the app

Once the app is deployed, you can POST your dice roll results from other devices like so:

```bash
curl \
  -H "Accept: application/json" \
  -H "Content-type: application/x-www-form-urlencoded" \
  -H "Authorization: Bearer {TOKEN-YOU-SET-IN-CREDENTIALS}" \
  -X POST \
  -d 'shortcode=C3' \
  {DEPLOYMENT-URL}/api/v2/games/{GAME-ID}/rolls
```

Please replace the values in curly braces (and the curly braces!) with the actual values provided in our password vault. The `GAME-ID` refers to the ID of the game route, e.g. `http://localhost:3000/games/1` (where the ID is 1 in this case.)

The important bit in the request is the shortcode payload that is sent. As of now, we have agreed that all dice emit their result via a mapping of A-C for the die and 1-6 for the result side. This means that currently the shortcodes `A{1-6}`, `B{1-6}`, and `C{1-6}` are valid. All other combinations will be rejected by the app.

> Note that it is not necessary to include a timestamp in the request body as the timestamp is set on the application server.

## Printing

The purpose of the app is to physically print a generated idea with a small label printer. We do this by opening the deployed Rails app in a browser. When a new idea is created, [some JavaScript](/app/javascript/controllers/localhost_post_controller.js) is executed on the Raspberry Pi that hosts the _local_ setup. A [local server on the Pi](https://github.com/technologiestiftung/idea-machine-printing-server) executes the print job then.
