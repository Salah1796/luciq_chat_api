require 'swagger_helper'

RSpec.describe 'Chats API', type: :request do
  path '/applications/{application_token}/chats' do
    parameter name: :application_token, in: :path, type: :string, description: 'Application token'

    get('List all chats for an application') do
      tags 'Chats'
      produces 'application/json'
      response(200, 'successful') do
        run_test!
      end
    end

    post('Create a chat under an application') do
      tags 'Chats'
      produces 'application/json'
      response(201, 'created') do
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
        run_test!
      end
    end
  end
end
