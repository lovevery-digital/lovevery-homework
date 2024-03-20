require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "POST /" do
    subject(:create_request) { post comments_path, params: params }

    context 'with valid params' do
      let(:product) { create :product }
      let(:params) do
        {
          comment: attributes_for(
            :comment,
            commentable_type: product.class.to_s,
            commentable_id: product.id
          )
        }
      end

      it 'creates new comment' do
        expect { create_request }.to change(Comment, :count).by(1)
      end

      it 'redirects to products path' do
        create_request
        expect(response).to redirect_to(product_path(product))
      end
    end

    context 'with missing params' do
      let(:product) { create :product }
      let(:params) do
        {
          comment: {
            commentable_id: product.id,
            commentable_type: product.class.to_s
          }
        }
      end

      it 'does not create any comment' do
        expect { create_request }.not_to change(Comment, :count).from(0)
      end

      it 'redirects to products path' do
        create_request
        expect(response).to redirect_to(product_path(product))
      end
    end
  end
end
