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
      product.save
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should produce error without price' do
      category = Category.new(name: "books")
      product = Product.new(name: 'bible', price_cents: nil, quantity: 2, category: category)
      product.save
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should produce error without quantity' do
      category = Category.new(name: "books")
      product = Product.new(name: 'bible', price_cents: 200, quantity: nil, category: category)
      product.save
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should produce error without category' do
      category = Category.new(name: "books")
      product = Product.new(name: 'bible', price_cents: 200, quantity: 2, category: nil)
      product.save
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end



