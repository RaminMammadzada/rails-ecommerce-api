module V1
  class CategoriesController < ApplicationController
    before_action :set_category, only: %i[show update destroy]

    # GET /categories
    def index
      # get paginated current user categories
      @categories = current_user.categories.paginate(page: category_params[:page], per_page: category_params[:per_page])
      json_response(@categories)
    end

    # POST /categories
    def create
      # create categories belonging to current user
      @category = current_user.categories.create!(category_params)
      json_response(@category, :created)
    end

    # GET /categories/:id
    def show
      json_response(@category)
    end

    # PUT /categories/:id
    def update
      @category.update(category_params)
      head :no_content
    end

    # DELETE /categories/:id
    def destroy
      @category.destroy
      head :no_content
    end

    private

    def category_params
      # whitelist params
      params.permit(:title, :page, :per_page)
    end

    def set_category
      @category = Category.find(params[:id])
    end
  end
end
