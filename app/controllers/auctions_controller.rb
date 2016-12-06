class AuctionsController < ApplicationController
  before_action :find_auction, only: [:show, :update, :destroy, :edit]
  before_action :authenticate_user, except: [:index, :show]

  def new
    @auction = Auction.new
  end

  def create
    byebug
    @auction = Auction.new auction_params
    @auction.user = current_user
    @auction.ends_on = (@auction.ends_on).to_date
    @auction.save
    redirect_to auction_path(@auction)
  end

  def index
    @auctions = Auction.order(created_at: :desc)
  end

  def show
    @bid = Bid.new
    @bids = Bid.where(auction_id: @auction).order(price: :desc)
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

# Add state machine with these states to the auction model: draft / published / reserve met / won / canceled / reserve not met. Add events to the state machine that trigger going from one state to another.
#
# Add user authentication and disallow users to bid on their own auctions.
#
# Implement the ability to publish an auction by having a "publish" button on the auction show page. This should only be visible to the creator of the auction.
