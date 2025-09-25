require 'swagger_helper'

RSpec.describe 'api/v1/clients', type: :request do
  path '/api/v1/clients' do
    get 'Lista todos los clientes' do
      tags 'Clients'
      produces 'application/json'
      response '200', 'Lista obtenida' do
        run_test!
      end
    end

    post 'Crea un cliente' do
      tags 'Clients'
      consumes 'application/json'
      parameter name: :client, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          email: { type: :string, format: :email }
        },
        required: %w[first_name last_name email]
      }

      response '201', 'Cliente creado' do
        let(:client) { { first_name: 'Juan', last_name: 'Pérez', email: 'juan@example.com' } }
        run_test!
      end

      response '422', 'Error de validación' do
        let(:client) { { first_name: '', last_name: '', email: 'mal-correo' } }
        run_test!
      end
    end
  end

  path '/api/v1/clients/{id}' do
    get 'Muestra un cliente' do
      tags 'Clients'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Cliente encontrado' do
        let(:id) { Client.create(first_name: 'Test', last_name: 'User', email: 'test@example.com').id }
        run_test!
      end

      response '404', 'Cliente no encontrado' do
        let(:id) { '9999' }
        run_test!
      end
    end

    put 'Actualiza un cliente' do
      tags 'Clients'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :client, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          email: { type: :string, format: :email }
        }
      }

      response '200', 'Cliente actualizado' do
        let(:id) { Client.create(first_name: 'Test', last_name: 'User', email: 'test@example.com').id }
        let(:client) { { first_name: 'Nuevo' } }
        run_test!
      end
    end

    delete 'Elimina un cliente' do
      tags 'Clients'
      parameter name: :id, in: :path, type: :string

      response '200', 'Cliente eliminado' do
        let(:id) { Client.create(first_name: 'Test', last_name: 'User', email: 'test@example.com').id }
        run_test!
      end
    end
  end
end
