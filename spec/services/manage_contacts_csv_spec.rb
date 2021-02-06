require 'rails_helper'

RSpec.describe ManageContactsCsv do

  let(:user) { create(:user) }
  let(:user2) { create(:user) }

  context "call" do
    it '' do
      file_path = "spec/fixtures/contacts.csv"
      result = ::ManageContactsCsv.new({file_path: file_path, user: user}).call
      expect(result.success?).to eq(true)
      expect(Contact.count).to eq(1)
    end  
  end
  
end