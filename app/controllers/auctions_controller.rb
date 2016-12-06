class AuctionsController < ApplicationController
  before_action :find_auction, only: [:show, :update, :destroy, :edit]
  before_action :authenticate_user, except: [:index, :show]

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new auction_params
    @auction.user = current_user
    if @auction.valid?
      @auction.ends_on = @auction.ends_on.to_date
      if @auction.save
        redirect_to auction_path(@auction)
      else
        render(:new)
      end
    end
  end

  def index
    @auctions = Auction.display_state.order(created_at: :desc)
  end

  def show
    @bid = Bid.new
    @bids = Bid.order(created_at: :desc).where(auction_id: @auction)
  end

  def edit
  end

  def update
    @auction.update auction_params
    redirect_to auction_path(@auction)
  end

  def destroy
    @auction.destroy
    redirect_to auctions_path
  end

  private

  def auction_params
    params.require(:auction).permit(:title,
                                    :description,
                                    :ends_on,
                                    :reserve_price)
  end

  def find_auction
    @auction = Auction.find params[:id]
  end
end
