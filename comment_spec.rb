require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    context 'when valid' do
      subject(:comment) { build :comment }

      it { is_expected.to be_valid }
      it 'has correct attributes' do
        expect(comment).to have_attribute(:commentable_id, :integer)
        expect(comment).to have_attribute(:commentable_type, :string)
        expect(comment).to have_attribute(:author_name, :string)
        expect(comment).to have_attribute(:content, :text)
      end
    end

    context 'with blank attributes' do
      subject(:comment) { described_class.new() }

      before { is_expected.to be_invalid }

      it 'has commentable must exist error' do
        expect(comment.errors[:commentable]).to include("must exist")
      end

      it 'has content cant be blank error' do
        expect(comment.errors[:content]).to include("can't be blank")
      end
    end
  end
end
