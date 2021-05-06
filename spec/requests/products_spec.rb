require 'rails_helper'

RSpec.describe 'Products API' do
  # Initialize the test data
  let!(:category) { create(:category) }
  let!(:products) { create_list(:product, 20, category_id: category.id) }
  let(:category_id) { category.id }
  let(:id) { products.first.id }

  # Test suite for GET /categories/:category_id/products
  describe 'GET /categories/:category_id/products' do
    before { get "/categories/#{category_id}/products" }

    context 'when category exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all category products' do
        expect(json.size).to eq(20)
      end
    end

    context 'when category does not exist' do
      let(:category_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Category/)
      end
    end
  end

  # Test suite for GET /categories/:category_id/products/:id
  describe 'GET /categories/:category_id/products/:id' do
    before { get "/categories/#{category_id}/products/#{id}" }

    context 'when category product exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the product' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when category product does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end

  # Test suite for PUT /categories/:category_id/products
  describe 'POST /categories/:category_id/products' do
    let(:valid_attributes) { { name: "Sample Product B", price: 44.1, details: "Great product" } }

    context 'when request attributes are valid' do
      before { post "/categories/#{category_id}/products", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/categories/#{category_id}/products", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /categories/:category_id/products/:id
  describe 'PUT /categories/:category_id/products/:id' do
    let(:valid_attributes) { { name: 'Sample Product A', price: 11.2, details: "sample details A" } }

    before { put "/categories/#{category_id}/products/#{id}", params: valid_attributes }

    context 'when product exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the product' do
        updated_product = Product.find(id)
        expect(updated_product.name).to match(/Sample Product A/)
      end
    end

    context 'when the product does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end

  # Test suite for DELETE /categories/:id
  describe 'DELETE /categories/:id' do
    before { delete "/categories/#{category_id}/products/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end