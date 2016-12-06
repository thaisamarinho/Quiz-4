class BidsController < ApplicationController
  before_action :authenticate_user

  def create
    find_auction
    @bid = Bid.new bid_params
    @bid.auction = @auction
    @bid.user = current_user
    if @auction.bids.max&.price == nil
      max_bid = 0
    else
      max_bid = @auction.bids.max&.price
    end
    if @bid.valid? && @bid.price > max_bid
      if @bid.save
        set_auction_state
        if @auction.reserve_met? && @auction.bids.max.price > @auction.reserve_price && @auction.ends_on < Date.today
          @auction.update_attributes(aasm_state: 'won')
        end

        respond_to do |format|
          format.js { render :create_success }
          format.html {redirect_to auction_path(@auction)}
        end
      else
        respond_to do |format|
          format.html { render ('auctions/show') }
          format.js { render :create_failure }
        end
      end
    else
      render ('auctions/show'), alert: 'Bid should be higher than max bid'
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:price)
  end

  def find_auction
    @auction = Auction.find params[:auction_id]
  end

  def set_auction_state
    if @auction.published? || @auction.reserve_not_met?
      if @bid.price < @auction.reserve_price
        @auction.update_attributes(aasm_state: 'reserve_not_met')
      else
        @auction.update_attributes(aasm_state: 'reserve_met')
      end
    end
  end
end
