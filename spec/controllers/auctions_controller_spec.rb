require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  describe '#new' do
    let(:user) {create(:user)}
    context 'with user signed in' do
      before {request.session[:user_id] = user.id}
      it 'renders new auction page' do
        get :new
        expect(response).to render_template(:new)
      end
      it 'instantiates a new auction object' do
        get :new
        expect(assigns(:auction)).to be_a_new(Auction)
      end
    end

    context 'with user signed out' do
      before {request.session[:user_id] = nil}
      it 'renders new auction page' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe '#create' do
    # let(:user) {create(:user)}
    context 'with valid params' do
      # before {request.session[:user_id] = user.id}
      def valid_params
        post :create, params: {auction: attributes_for(:auction)}
      end

      it 'saves the record to the database' do
        count_before = Auction.count
        valid_params
        count_after = Auction.count
        expect(count_after).to eq(count_before + 1)
      end


    end
    context 'with invalid params' do

    end
  end
end
