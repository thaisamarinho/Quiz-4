require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  let(:user) { create(:user) }
  let(:auction) { create(:auction) }

  describe '#create' do
    context 'with valid params' do
      before { request.session[:user_id] = user.id }
      def valid_params
        post :create, params: { auction_id: auction, bid: attributes_for(:bid, user: user) }
      end

      it 'saves the record to the database' do
        count_before = Bid.count
        valid_params
        count_after = Bid.count
        expect(count_after).to eq(count_before + 1)
      end
    end

    context 'with invalid params' do
      before { request.session[:user_id] = user.id }
      def invalid_params
        post :create, params: { auction_id: auction, bid: {price: nil, user: user} }
      end
      it 'does not saves the record to the database' do
        count_before = Bid.count
        invalid_params
        count_after = Bid.count
        expect(count_after).to eq(count_before)
      end
    end
  end

end
