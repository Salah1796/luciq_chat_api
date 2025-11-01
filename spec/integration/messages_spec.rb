require 'swagger_helper'

RSpec.describe 'Messages API', type: :request do
  path '/applications/{application_token}/chats/{chat_number}/messages' do
    parameter name: :application_token, in: :path, type: :string
    parameter name: :chat_number, in: :path, type: :integer

    get('List all messages in a chat') do
      tags 'Messages'
      produces 'application/json'
      response(200, 'successful') do
        run_test!
      end
    end

    post('Create a new message') do
      tags 'Messages'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :message, in: :body, schema: {
        type: :object,
        properties: { body: { type: :string } },
        required: ['body']
      }

      response(201, 'created') do
        run_test!
      end
    end
  end

  path '/applications/{application_token}/chats/{chat_number}/messages/{id}' do
    parameter name: :application_token, in: :path, type: :string
    parameter name: :chat_number, in: :path, type: :integer
    parameter name: :id, in: :path, type: :integer

    get('Show message details') do
      tags 'Messages'
      produces 'application/json'
      response(200, 'successful') do
        run_test!
      end
    end
  end

  path '/applications/{application_token}/chats/{chat_number}/messages/search' do
    parameter name: :application_token, in: :path, type: :string
    parameter name: :chat_number, in: :path, type: :integer
    parameter name: :q, in: :query, type: :string, description: 'Search query'

    get('Search messages in chat') do
      tags 'Messages'
      produces 'application/json'
      response(200, 'successful') do
        run_test!
      end
    end
  end
end
