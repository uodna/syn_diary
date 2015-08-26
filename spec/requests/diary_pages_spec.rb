require 'spec_helper'

describe "DiaryPages" do
  describe "GET /diary_pages" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit root_path
      expect(page).to have_content('スタッフ日報')
    end
  end
end
