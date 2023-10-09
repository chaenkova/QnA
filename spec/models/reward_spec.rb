require 'rails_helper'

RSpec.describe Reward do
  it { should belong_to :question }
  it { should belong_to(:user).optional }

  it do
    expect(described_class.new.image).not_to be_valid
  end

  it 'have one attached image' do
    expect(described_class.new.image).to be_an_instance_of ActiveStorage::Attached::One
  end
end