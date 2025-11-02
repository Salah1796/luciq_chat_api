# Luciq Chat API

This project provides a robust and scalable chat API built with Ruby on Rails. It enables the creation and management of applications, chats within those applications, and messages within those chats. Key features include:

*   **Application Management:** Create, retrieve, and update chat applications.
*   **Chat Management:** Create and retrieve chats associated with specific applications.
*   **Message Management:** Create, retrieve, and search messages within chats.
*   **Containerized Environment:** Easy setup and deployment using Docker.

## Technologies Used

*   **Backend:** Ruby on Rails
*   **Database:** MySQL
*   **Background Processing:** Sidekiq (with Redis)
*   **Search:** Elasticsearch
*   **API Documentation:** Rswag (OpenAPI/Swagger)
*   **Containerization:** Docker, Docker Compose

## Prerequisites

*   Docker
*   Docker Compose

## Setup

Follow these steps to get the Luciq Chat API up and running on your local machine:

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Salah1796/luciq_chat_api
    cd luciq_chat_api
    ```
2.  **Build Docker images:**
    ```bash
    docker-compose build
    ```
3.  **Start the application:**
    ```bash
    docker-compose up -d # Runs in detached mode
    ```

The application will be accessible at `http://localhost:3000`.

Database preparation (creation, migration, and seeding) is now automated and will run when the application starts.

To stop the application, run:
```bash
docker-compose down
```

## API Documentation (Swagger UI)

Access the interactive API documentation (Swagger UI) at:

`http://localhost:3000/api-docs/index.html`

*Note: If the documentation does not reflect the latest changes, you might need to regenerate it by running `docker-compose run --rm app bundle exec rake rswag:specs:swaggerize`.*

## API Endpoints

The API provides the following main resources:

### Applications

*   **`GET /applications`**: Retrieve a list of all chat applications.
*   **`GET /applications/{token}`**: Retrieve details for a specific application using its unique token.
*   **`POST /applications`**: Create a new chat application.
*   **`PUT /applications/{token}`**: Update an existing chat application.

### Chats

*   **`GET /applications/{token}/chats`**: Retrieve all chats associated with a specific application.
*   **`GET /applications/{token}/chats/{number}`**: Retrieve details for a specific chat within an application using its number.
*   **`POST /applications/{token}/chats`**: Create a new chat under a specific application.

### Messages

*   **`GET /applications/{token}/chats/{number}/messages`**: Retrieve all messages within a specific chat.
*   **`GET /applications/{token}/chats/{number}/messages/{number}`**: Retrieve details for a specific message within a chat using its number.
*   **`POST /applications/{token}/chats/{number}/messages`**: Create a new message within a specific chat.
*   **`GET /applications/{token}/chats/{number}/messages/search?q={someText}`**: Search for messages within a specific chat using a query string.

## Running the test suite

To run the test suite, execute the following command:

```bash
docker-compose run --rm app bundle exec rails test
```