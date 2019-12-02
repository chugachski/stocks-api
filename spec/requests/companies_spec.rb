require 'rails_helper'

RSpec.describe 'Companies API', type: :request do
  # init test data
  let!(:companies) { FactoryBot.create_list(:company, 10) }
  let(:company_id) { companies.first.id }

  describe 'GET /api/companies' do
    # make http req before each example
    before { get '/api/companies' }

    it 'returns companies' do
      # note: json custom helper parses the json resp into ruby hash
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/companies/:id' do
    before { get "/api/companies/#{company_id}" }

    context 'when record exists' do
      it 'returns the company' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(company_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200) # OK
      end
    end

    context 'when the record does not exist' do
      let(:company_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404) # not found
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Company/)
      end
    end
  end

  describe 'POST /api/companies' do
    # valid payload
    let(:valid_attributes) { { company: { name: 'Microsoft Corporation', symbol: 'MSFT' } } }

    context 'when the request is valid' do
      before { post '/api/companies', params: valid_attributes }

      it 'creates a company' do
        expect(json['name']).to eq('Microsoft Corporation')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201) # created
      end
    end

    context 'when the request is invalid' do
      before { post '/api/companies', params: { company: { name: 'Microsoft Corporation' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422) # unprocessable entity
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"symbol\":[\"can't be blank\"]}")
      end
    end
  end

  describe 'PUT /api/companies/:id' do
    let(:valid_attributes) { { company: { name: 'Mondelez International Inc.' } } }

    context 'when the record exists' do
      before { put "/api/companies/#{company_id}", params: valid_attributes }

      it 'updates the record' do
          expect(json['name']).to eq('Mondelez International Inc.')
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(200) # ok
      end
    end
  end

  describe 'POST /api/companies/:id' do
    before { delete "/api/companies/#{company_id}" }

    it 'return status code 204' do
      expect(response).to have_http_status(204) # no content
    end
  end

end
