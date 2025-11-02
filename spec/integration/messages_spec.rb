require 'swagger_helper'

RSpec.describe 'Messages API', type: :request do
  path '/applications/{application_token}/chats/{chat_number}/messages' do
    parameter name: :application_token, in: :path, type: :string
    get('List all messages in a chat') do
      tags 'Messages'
      produces 'application/json'
      response(200, 'successful') do
        schema type: :object,
               properties: {
                 success: { type: :boolean, example: true },
                 message: { type: :string, nullable: true, example: nil },
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       number: { type: :integer, example: 1 },
                       body: { type: :string, example: 'Hello World' }
                     },
                     required: %w[number body]
                   }
                 },
                 status: { type: :integer, example: 200 }
               },
               required: %w[success data status]
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
        schema type: :object,
               properties: {
                 success: { type: :boolean, example: true },
                 message: { type: :string, nullable: true, example: nil },
                 data: {
                   type: :object,
                   properties: {
                     number: { type: :integer, example: 1 },
                     body: { type: :string, example: 'Hello World' }
                   },
                   required: %w[number body]
                 },
                 status: { type: :integer, example: 201 }
               },
               required: %w[success data status]
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
        schema type: :object,
               properties: {
                 success: { type: :boolean, example: true },
                 message: { type: :string, nullable: true, example: nil },
                 data: {
                   type: :object,
                   properties: {
                     number: { type: :integer, example: 1 },
                     body: { type: :string, example: 'Hello World' }
                   },
                   required: %w[number body]
                 },
                 status: { type: :integer, example: 200 }
               },
               required: %w[success data status]
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
        schema type: :object,
               properties: {
                 success: { type: :boolean, example: true },
                 message: { type: :string, nullable: true, example: nil },
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       number: { type: :integer, example: 1 },
                       body: { type: :string, example: 'Hello World' }
                     },
                     required: %w[number body]
                   }
                 },
                 status: { type: :integer, example: 200 }
               },
               required: %w[success data status]
        run_test!
      end
    end
  end
end
