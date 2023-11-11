require 'rails_helper'

shared_examples_for 'votable' do
  context 'associations' do
    it { should have_many(:votes).dependent(:destroy) }
  end

  context 'public methods' do
    let(:second_user) { create(:user) }

    context 'not rated yet' do
      it '#vote_plus' do
        resource.vote_plus(user)
        expect(resource.votes.where(user: user).last.value).to eq(1)
      end

      it '#vote_minus' do
        resource.vote_minus(user)
        expect(resource.votes.where(user: user).last.value).to eq(-1)
      end

      it '#voted_before?' do
        expect(resource.votes.where(user: user).any?).to be_falsy
      end

      it '#rating' do
        expect(resource.votes.sum(:value)).to eq(0)
      end
    end

    context 'rated before' do
      before { resource.vote_plus(user) }

      it '#vote_plus' do
        resource.vote_plus(user)
        expect(resource.votes.where(user: user).last.value).to eq(1)
      end

      it '#vote_minus' do
        resource.vote_minus(user)
        expect(resource.votes.where(user: user).last.value).to eq(1)
      end

      it '#cancel' do
        resource.cancel(user)
        expect(resource.votes.where(user: user).any?).to be_falsy
      end

      it '#voted_before?' do
        expect(resource.votes.where(user: user).any?).to be_truthy
      end

      it '#rating' do
        resource.vote_plus(second_user)
        expect(resource.votes.sum(:value)).to eq(2)
      end
    end
  end
end