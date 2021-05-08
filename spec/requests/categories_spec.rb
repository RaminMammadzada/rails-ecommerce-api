# spec/requests/categories_spec.rb
require 'spec_helper'

RSpec.describe 'Categories API', type: :request do
  # initialize test data
  # add todos owner
  let(:user) { create(:user) }
  let!(:categories) { create_list(:category, 10, created_by: user.id) }
  let(:category_id) { categories.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /categories
  describe 'GET /categories' do
    # make HTTP get request before each example
    before { get '/categories', params: {}, headers: headers }

    it 'returns categories' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /categories/:id
  describe 'GET /categories/:id' do
    # make HTTP get request before each example
    before { get "/categories/#{category_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the category' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(category_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record doesn't exist" do
      let!(:category_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Category/)
      end
    end
  end

  # Test suite for POST /categories
  describe 'POST /categories' do
    # valid payload
    let(:valid_attributes) { { title: 'Sample category name 1', created_by: user.id.to_s }.to_json }

    context 'when the request is valid' do
      before { post '/categories', params: valid_attributes, headers: headers}

      it 'creates a category' do
        expect(json['title']).to eq('Sample category name 1')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is not valid' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/categories', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'return a validation failure message' do
        expect(json['message']).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite for PUT /categories/:id
  describe 'PUT /cateogires/:id' do
    let(:valid_attributes) { { title: 'Jackets' }.to_json }

    context 'when the record exists' do
      before { put "/categories/#{category_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /categories/:id' do
    before { delete "/categories/#{category_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
