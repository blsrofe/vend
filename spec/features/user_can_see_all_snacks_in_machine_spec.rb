require "rails_helper"

RSpec.describe "When a user visits a vending machine show page" do
  it "they see all snacks with their prices" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack_1 = dons.snacks.create(name: "Oreos", price: 2.99)
    snack_2 = dons.snacks.create(name: "Skittles", price: 1.25)

    visit machine_path(dons)

    expect(page).to have_content("Oreos: 2.99")
    expect(page).to have_content("Skittles: 1.25")
  end

  it "they see the average price for all snacks" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack_1 = dons.snacks.create(name: "Oreos", price: 1.50)
    snack_2 = dons.snacks.create(name: "Skittles", price: 1.00)

    visit machine_path(dons)

    expect(page).to have_content("Average Price: 1.25")
  end
end
