require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save for a product with all 4 validation fields entered' do
      @category = Category.new
      @product = Product.new({ name: 'Toy Car', price: 1000, quantity: 50, category: @category })
      @product.save!

      expect(@product.id).to be_present
    end

    it 'should NOT be valid for a product without a category' do
      @product = Product.new({ name: 'Toy Car', price: 1000, quantity: 50 })
      
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eq ["Category can't be blank"]
    end

    it 'should NOT be valid for a product without a name' do
      @category = Category.new
      @product = Product.new({ price: 1000, quantity: 50, category: @category })
      
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eq ["Name can't be blank"]
    end

    it 'should NOT be valid for a product without a price' do
      @category = Category.new
      @product = Product.new({ name: 'Toy Car', quantity: 50, category: @category })
      
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end

    it 'should NOT be valid for a product without a quantity' do
      @category = Category.new
      @product = Product.new({ name: 'Toy Car', price: 1000, category: @category })
      
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eq ["Quantity can't be blank"]
    end
  end
end
