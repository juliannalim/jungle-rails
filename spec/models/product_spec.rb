require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should save each field successfully' do
      category = Category.new(name: "books")
      product = Product.new(name: 'bible', price_cents: 200, quantity: 2, category: category)
      expect(product).to be_valid
      product.errors.full_messages
    end

    it 'should produce error without name' do
      category = Category.new(name: "books")
      product = Product.new(name: '', price_cents: 200, quantity: 2, category: category)
      expect(product).to_not be_valid
      product.errors.full_messages
    end

    it 'should produce error without price' do
      category = Category.new(name: "books")
      product = Product.new(name: 'bible', price_cents: nil, quantity: 2, category: category)
      expect(product).to_not be_valid
      product.errors.full_messages
    end

    it 'should produce error without quantity' do
      category = Category.new(name: "books")
      product = Product.new(name: 'bible', price_cents: 200, quantity: nil, category: category)
      expect(product).to_not be_valid
      product.errors.full_messages
    end

    it 'should produce error without category' do
      category = Category.new(name: "books")
      product = Product.new(name: 'bible', price_cents: 200, quantity: 2, category: nil)
      expect(product).to_not be_valid
      product.errors.full_messages
    end
  end
end



