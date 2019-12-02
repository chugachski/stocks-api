require 'rails_helper'

RSpec.describe 'StatsProfiles API', type: :request do
  # init test data
  let!(:company) { FactoryBot.create(:company) }
  let!(:stats_profiles) { FactoryBot.create_list(:stats_profile, 5, company_id: company.id) } # NOTE: faker may gen the same year 2x causing a validation error
  let(:company_id) { company.id }
  let(:stats_profile_id) { stats_profiles.first.id }

  describe 'GET /api/stats_profiles' do
    # make http req before each example
    before { get '/api/stats_profiles' }

    it 'returns stats_profiles' do
      # note: json custom helper parses the json resp into ruby hash (see request_spec_helper)
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/stats_profiles/:id' do
    before { get "/api/stats_profiles/#{stats_profile_id}" }

    context 'when record exists' do
      it 'returns the company' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(stats_profile_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200) # OK
      end
    end

    context 'when the record does not exist' do
      let(:stats_profile_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404) # not found
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find StatsProfile/)
      end
    end
  end

  describe 'POST /api/stats_profiles' do
    # valid payload
    let(:valid_attributes) { { stats_profile: { company_id: company_id, year: "2014", min: 45.56, max: 52.12, avg: 47.87, ending: 45.10, volatility: 1.29, annual_change: 4.2 } } }

    context 'when the request is valid' do
      before { post '/api/stats_profiles', params: valid_attributes }

      it 'creates a company' do
        expect(json['avg']).to eq(47.87)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201) # created
      end
    end

    context 'when the request is invalid' do
      before { post '/api/stats_profiles', params: { stats_profile: { company_id: company_id, min: 45.56, max: 52.12, avg: 47.87, ending: 45.10, volatility: 1.29, annual_change: 4.2 } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422) # unprocessable entity
      end

      it 'returns a validation failure message' do
        expect(response.body).not_to be_nil
      end
    end
  end

  describe 'PUT /api/stats_profiles/:id' do
    let(:valid_attributes) { { stats_profile: { volatility: 1.01 } } }

    context 'when the record exists' do
      before { put "/api/stats_profiles/#{stats_profile_id}", params: valid_attributes }

      it 'updates the record' do
          expect(json['volatility']).to eq(1.01)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(200) # ok
      end
    end
  end

  describe 'POST /api/stats_profiles/:id' do
    before { delete "/api/stats_profiles/#{stats_profile_id}" }

    it 'return status code 204' do
      expect(response).to have_http_status(204) # no content
    end
  end

end
