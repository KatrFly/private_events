require 'rails_helper'

RSpec.describe 'Some first system tests', type: :system do
  describe 'nothing' do
    it 'does not raise an error' do
      visit root_path

      sleep 5
      expect(page).to have_content('Private')
    end
  end
end