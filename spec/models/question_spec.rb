require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :title}
  it { should validate_presence_of :body}
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:links).dependent(:destroy) }
  it { should have_one(:reward).dependent(:destroy) }
  it { should belong_to :user}
  it { should have_many(:subscriptions).dependent(:destroy) }

  it { should accept_nested_attributes_for :links }
  it { should accept_nested_attributes_for :reward }

  it 'have many attached files' do
    expect(Question.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  describe 'shared examples' do
    it_behaves_like 'votable' do
      let(:user) { create(:user) }
      let!(:resource) { create(:question, user: user) }
    end
    it_behaves_like 'commentable'
  end
end