require 'rails_helper'

RSpec.describe User, type: :model do
  it {should have_many(:questions).dependent(:destroy) }
  it {should have_many(:answers).dependent(:destroy) }
  it {should have_many(:authorizations).dependent(:destroy) }

  describe 'Check author' do
    let(:user) { create(:user) }
    let(:new_user) { create(:user) }
    let(:question)  { create(:question, user: user) }

    it 'current user is an author' do
      expect(user).to be_author(question)
    end

    it "current user isn't an author" do
      expect(new_user).to_not be_author(question)
    end
  end

  describe '.find_for_oauth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }
    let(:service) { double('FindForOauthService') }

    it 'calls FindForOauthService' do
      expect(FindForOauthService).to receive(:new).with(auth).and_return(service)
      expect(service).to receive(:call)
      User.find_for_oauth(auth)
    end
  end
end
