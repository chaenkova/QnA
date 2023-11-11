require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question ) }
  it { should belong_to :user}
  it { should have_many(:links).dependent(:destroy) }
  it { should validate_presence_of :body}
  it { should accept_nested_attributes_for :links }

  describe 'shared examples' do
    it_behaves_like 'votable' do
      let(:user) { create(:user) }
      let!(:question) { create(:question, user: user) }
      let!(:resource) { create(:answer, question: question, user: user) }
    end
  end
end