require 'swagger_helper'

RSpec.describe 'Applications API', type: :request do
  path '/applications' do
    get('List all applications') do
      tags 'Applications'
      produces 'application/json'

      response(200, 'successful') do
        run_test!
      end
    end

    post('Create an application') do
      tags 'Applications'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :application, in: :body, schema: {
        type: :object,
        properties: { name: { type: :string } },
        required: ['name']
      }

      response(201, 'created') do
        run_test!
      end
    end
  end

  path '/applications/{token}' do
    parameter name: :token, in: :path, type: :string, description: 'Application token'

    get('Show application details') do
      tags 'Applications'
      produces 'application/json'
      response(200, 'successful') do
        run_test!
      end
    end

    patch('Update an application') do
      tags 'Applications'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :application, in: :body, schema: {
        type: :object,
        properties: { name: { type: :string } }
      }

      response(200, 'updated') do
        run_test!
      end
    end
  end
end
