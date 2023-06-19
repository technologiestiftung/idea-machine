# (Semi-serious) Idea Machine

Web app that creates ChatGPT-generated ideas for the digitalization of Berlin. The ideas are explicitly semi-serious and are intended as a conversation starter. The ideas are generated from physical die rolls that emit their result side and POST it to the web app. Each side is associated with a term such as "App", "Bäume", etc. that serves as input to the idea generation.

> This app is a Ruby on Rails application.

## Open todo's

- [x] Setup resources for dice/sides/etc.
- [x] Create UI that always shows latest die rolls
- [x] Document POSTing via JSON
- [x] Setup GitHub action CI (including tests and linting)
- [x] Add code quality and security tooling (SimpleCov, Brakeman, etc.)
- [x] Enable creation of ideas via button press (from ChatGPT)
- [x] Streamline flow between idea creation and return to die roll view
- [ ] Enbale printing result to paper
- [x] Consider protecting JSON endpoint with simple auth check
- [x] Protect everything with simple HTTP Auth
- [x] save associated rolls with idea
- [x] Style UI
- [x] Animate arrival of new rolls

## Requirements

- Ruby version as defined in `.ruby-version`
- SQLite3
- Redis

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

This app is primarily developed for a local exhibition context. It is therefore to be deployed locally on a Raspberyy Pi.

### Raspberry Pi Setup

We set up the app on a Rapberry Pi 4 Model B with 4GB RAM. Make sure that you install the 64bit version of the Raspberry Pi OS.

The first steps will be to install our required system dependencies. We then proceed to install and start the Rails app.

#### Installing Ruby

We want to install and configure Ruby through a version manager (`rbenv`):

```bash
sudo apt-get install rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> .bashrc
echo 'eval "$(rbenv init -)"' >> .bashrc
```

We then need to install the `ruby-build` plugin in order to access our Ruby versions:

```bash
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
```

We can now inspect the available versions via:

```bash
rbenv install --list
```

Now we can install our desired Ruby version (defined in `.ruby-version`, `3.2.0` as of now).

```bash
rbenv install 3.2.0
```

> That actually failed the first time I tried. I've had to `sudo apt-get install libyaml-dev` to install libyaml and then run `rbenv install 3.2.0` again.

#### Installing SQLite3

```bash
sudo apt-get install sqlite3
```

Ensure this worked by inspecting `sqlite3 --version`

#### Installing Redis

```bash
sudo apt-get install redis-server
```

That's it. For me, Redis was started automatically. If it isn't try running `sudo systemctl enable redis` and then `sudo systemctl start redis`.

#### Setup app

Git should already be installed on the Raspberry Pi. So getting the code should be as simple as (specify a different directory if you prefer):

```bash
git clone https://github.com/technologiestiftung/idea-machine.git
```

Install dependencies:

```bash
bundle install
```

Create a file for the Rails master key (used for decrypting credentials):

```bash
touch config/master.key
```

This is a simple text file. Write the master key into that file. You can find it in our shared password vault. The key is a combination of letters and digits.

Now create and migrate the database:

```bash
RAILS_ENV=production bin/rails db:create
RAILS_ENV=production bin/rails db:migrate
```

Seed the database with the dice and sides and keywords:

```bash
RAILS_ENV=production bin/rails db:seed
```

We also need to precompile our assets (at the moment this is only our Tailwind CSS):

```bash
RAILS_ENV=production bin/rails assets:precompile
```

Then, we spin up the Rails server and make it available for devices on the same network:

```bash
RAILS_ENV=production RAILS_SERVE_STATIC_FILES=true bin/rails s -b 0.0.0.0
```

The app will be available at http://0.0.0.0:3000

You can now POST your dice roll results from other devices like so:

```bash
curl \
  -H "Accept: application/json" \
  -H "Content-type: application/x-www-form-urlencoded" \
  -H "Authorization: Bearer {TOKEN-YOU-SET-IN-CREDENTIALS}" \
  -X POST \
  -d 'shortcode=C3' \
  {HOSTNAME-OR-IP-OF-YOUR-RASPBERRY-PI}:3000/api/v1/rolls
```

Please replace the values in curly braces (and the curly braces!) with the actual values provided in our password vault.

The important bit in the request is the shortcode payload that is sent. As of now, we have agreed that all dice emit their result via a mapping of A-C for the die and 1-6 for the result side. This means that currently the shortcodes `A{1-6}`, `B{1-6}`, and `C{1-6}` are valid. All other combinations will be rejected by the app.

> Note that it is not necessary to include a timestamp in the request body as the timestamp is set on the application server.

### Fly.io

For testing and debugging reasons, we also deployed an instance to Fly.io.

Follow their [docs for deploying a Rails app](https://fly.io/docs/rails/getting-started/existing/) and for [using SQLite3](https://fly.io/docs/rails/advanced-guides/sqlite3/) as a database.

Once the app is deployed to Fly, we currently manually ran `fly ssh console -C "/rails/bin/rails db:seed"` to seed the database with the initial dice data.
