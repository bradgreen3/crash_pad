require 'rails_helper'

describe "as a not logged in user" do
  context "when I enter a criteria and click search" do

    let!(:denver) { create_list(:listing, 2, state: "CO", city: "Denver") }
    let!(:denver_iowa) { create(:listing, state: "IA", city: "Denver") }
    let!(:austin) { create(:listing, state: "TX", city: "Austin") }
    let!(:dallas) { create(:listing, state: "TX", city: "Dallas") }

    context "when I search by city" do
      xit "should return all listings within that city" do
        visit root_path

        fill_in :q, with: "Denver"

        click_button "Search"

        expect(current_path).to eq(listings_path)
        expect(page).to have_content(denver.first.city)
        expect(page).to have_content(denver.last.city)
        expect(page).to have_content(denver_iowa.city)
      end
    end

    context "when I search by state" do
      it "should return all listings within that state" do
        visit root_path

        fill_in :q, with: "Texas"

        click_button "Search"

        expect(current_path).to eq(listings_path)
        expect(page).to have_content(austin.city)
        expect(page).to have_content(dallas.city)
      end
    end
  end

  context "when I enter a criteria with no listings and click Search" do
    it "should return a message indicating no results" do
      visit root_path

      fill_in :q, with: "testestest"

      click_button "Search"

      expect(current_path).to eq(listings_path)
      expect(page).to have_content("No Available Listings")
    end
  end
end
