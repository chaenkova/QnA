require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should belong_to :linkable }

  it { should validate_presence_of :name }
  it { should validate_url_of :url }

  describe '#gist?' do
    context 'when gist' do
      let(:link) { create(:link, :gist) }

      it do
        expect(link.gist?).to be_truthy
      end
    end

    context 'when not gist' do
      let(:link) { create(:link) }

      it do
        expect(link.gist?).to be_falsey
      end
    end
  end
end