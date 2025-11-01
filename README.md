# Luciq Chat API

This is a Ruby on Rails application that provides a chat API. The application is containerized and can be run using Docker Compose.

## Prerequisites

* Docker
* Docker Compose

## Setup

1.  Clone the repository.
2.  Run `docker-compose build` to build the Docker images.
3.  Run `docker-compose up` to start the application.
4.  Run `docker-compose run --rm app bundle exec rails db:prepare` to create and set up the database.

The application will be available at `http://localhost:3000`.

## API Endpoints

### Applications

*   `GET /applications`: Get all applications.
*   `GET /applications/{token}`: Get a single application.
*   `POST /applications`: Create a new application.
*   `PUT /applications/{token}`: Update an application.

### Chats

*   `GET /applications/{token}/chats`: Get all chats for an application.
*   `GET /applications/{token}/chats/{number}`: Get a single chat.
*   `POST /applications/{token}/chats`: Create a new chat.

### Messages

*   `GET /applications/{token}/chats/{number}/messages`: Get all messages for a chat.
*   `GET /applications/{token}/chats/{number}/messages/{number}`: Get a single message.
*   `POST /applications/{token}/chats/{number}/messages`: Create a new message.
*   `GET /applications/{token}/chats/{number}/messages/search?q={someText}`: Search for messages in a chat.

## Running the test suite

To run the test suite, run the following command:

```
docker-compose run --rm app bundle exec rails test
```

## Bonus Tasks

*   The chat and message creation endpoints are not implemented in Go.
*   The test suite is not fully implemented.