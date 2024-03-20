RSpec.shared_examples "a commentable model" do
  it 'has many comments' do
    expect(described_class.reflect_on_association(:comments).macro).to eq(:has_many)
    # is_expected.to have_many(:comments)
  end

  context 'when having no comments' do
    it 'returns an empty set of comments' do
      expect(subject.comments).to be_empty
    end
  end

  context 'when having multiple comments' do
    let!(:comments) { create_list :comment, 3, commentable: subject }

    it 'returns a set of comments' do
      expect(subject.comments).not_to be_empty
    end

    it 'returns the right comments' do
      expect(subject.comments).to match_array(comments)
    end
  end
end
