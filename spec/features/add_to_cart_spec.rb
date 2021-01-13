require 'rails_helper'

RSpec.feature "Visitor adds item to cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'Visitor clicks to add item to cart, and My Cart is updated' do
    # ACT
    visit root_path

    first('article.product').find_button('Add').click

    expect(page).to have_content 'My Cart (1)'
  end
end
