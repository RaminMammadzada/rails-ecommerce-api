require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # Association test
  # ensure a product record belongs to a single Category record
  it { should belong_to(:category) }

  # Validation tests
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
