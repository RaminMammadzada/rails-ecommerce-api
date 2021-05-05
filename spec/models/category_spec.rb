require 'rails_helper'

RSpec.describe Category, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # Association test
  # ensure Category modelhas a 1:m relationshp with the Product model
  it { should have_many(:products).dependent(:destroy) }

  # Validation tests
  # ensure column title is presented before saving
  it { should validate_presence_of(:title) }

end
