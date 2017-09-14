require "rails_helper"

RSpec.describe "User visits snack show page" do
  it "and sees attribute for that snack" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack_1 = dons.snacks.create(name: "Oreos", price: 1.75)

    visit snack_path(snack_1)

    expect(page).to have_content("Oreos")
    expect(page).to have_content("Price: $1.75")
  end

  it "and sees a list of locations that sell that snack" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    bills = owner.machines.create(location: "Bill's Snack Emporium")
    snack = Snack.create(name: "Oreos", price: 1.75)
    dons.snacks << snack
    bills.snacks << snack

    visit snack_path(snack)

    expect(page).to have_content("Don's Mixed Drinks")
    expect(page).to have_content("Bill's Snack Emporium")
  end

  it "and sees the avergae price of snacks in each machine that sell that snack" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    bills = owner.machines.create(location: "Bill's Snack Emporium")
    snack = Snack.create(name: "Oreos", price: 1.75)
    snack_2 = Snack.create(name: "Skittles", price: 1.95)
    dons.snacks << snack
    bills.snacks << snack
    dons.snacks << snack_2

    visit snack_path(snack)

    expect(page).to have_content("average price of $1.85")
    expect(page).to have_content("average price of $1.75")
  end

  it "sees a count of the different kinds of items in the machine" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    bills = owner.machines.create(location: "Bill's Snack Emporium")
    snack = Snack.create(name: "Oreos", price: 1.75)
    snack_2 = Snack.create(name: "Skittles", price: 1.95)
    dons.snacks << snack
    bills.snacks << snack
    dons.snacks << snack_2

    visit snack_path(snack)

    expect(page).to have_content("Don's Mixed Drinks (2 kinds of snacks, average price of $1.85)")
    expect(page).to have_content("Bill's Snack Emporium (1 kinds of snacks, average price of $1.75)")
  end
end
