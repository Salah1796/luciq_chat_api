require 'swagger_helper'

RSpec.describe 'Chats API', type: :request do
  path '/applications/{application_token}/chats' do
    parameter name: :application_token, in: :path, type: :string, description: 'Application token'

    get('List all chats for an application') do
      tags 'Chats'
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
                       messages_count: { type: :integer, example: 0 }
                     },
                     required: %w[number messages_count]
                   }
                 },
                 status: { type: :integer, example: 200 }
               },
               required: %w[success data status]
        run_test!
      end
    end

    post('Create a chat under an application') do
      tags 'Chats'
      produces 'application/json'
      response(201, 'created') do
        schema type: :object,
               properties: {
                 success: { type: :boolean, example: true },
                 message: { type: :string, nullable: true, example: nil },
                 data: {
                   type: :object,
                   properties: {
                     number: { type: :integer, example: 1 },
                     messages_count: { type: :integer, example: 0 }
                   },
                   required: %w[number messages_count]
                 },
                 status: { type: :integer, example: 201 }
               },
               required: %w[success data status]
        run_test!
      end
    end
  end

  path '/applications/{application_token}/chats/{number}' do
    parameter name: :application_token, in: :path, type: :string
    parameter name: :number, in: :path, type: :integer

    get('Show a chat by number') do
      tags 'Chats'
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
                     messages_count: { type: :integer, example: 0 }
                   },
                   required: %w[number messages_count]
                 },
                 status: { type: :integer, example: 200 }
               },
               required: %w[success data status]
        run_test!
      end
    end
  end
end
