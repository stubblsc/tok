require 'rails_helper'

RSpec.describe Category, type: :model do
  subject{build :category}

  describe 'sanity check' do
    it{expect(subject).to be_valid}

    let(:no_name){build(:category, :no_name)}
    it 'must have a name' do
      expect(no_name).not_to be_valid
      expect(no_name.save).to be_falsey
    end
  end
end
