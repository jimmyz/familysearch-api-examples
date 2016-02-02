# Ruby Example Requests
This project contains examples on how to make FamilySearch API requests in the Ruby language. It uses the [Faraday HTTP gem](https://github.com/lostisland/faraday) to make requests.

## Setup

To setup this project to run, complete the following steps:

1. Clone the project to a local folder
2. Open a terminal, navigate to the "ruby" directory and install depencies by using [bundler](http://bundler.io).

```bash
bundle install
```

That's it! You should be ready to run the examples.

## Run Examples

Before you run the examples, you will need an access token from the [FamilySearch Sandbox](https://sandbox.familysearch.org/platform/). If you don't yet have an account on the sandbox, you can acquire on by registering as a developer on the [FamilySearch developer portal](https://familysearch.org/developers/). 

1. [Acquire Sandbox Access Token](https://sandbox.familysearch.org/platform/)
2. Copy/Paste the Access token into the file named `access_token.txt`. Note: This access token expires after one hour of inactivity. When building your application, you will need to use [OAuth2 to obtain the access token](https://familysearch.org/developers/docs/guides/authentication).
3. Run the following commands to execute the examples:

```bash
bundle exec ruby 01_read_person_simple.rb
```

```bash
bundle exec ruby 02_read_person_link.rb
```

```bash
bundle exec ruby 03_read_person_parents.rb
```


