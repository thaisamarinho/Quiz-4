class TransitionsController < ApplicationController
  before_action :find_auction

  def create_publish
    if @auction.publish!
      redirect_to @auction
    else
      redirect_to home
    end
  end

  def create_cancel
    if @auction.cancel!
      redirect_to @auction
    else
      redirect_to home
    end
  end

  def create_met
    if @auction.met!
      redirect_to @auction
    else
      redirect_to home
    end
  end

  def create_not_met
    if @auction.not_met!
      redirect_to @auction
    else
      redirect_to home
    end
  end

  def create_win
    if @auction.win!
      redirect_to @auction
    else
      redirect_to home
    end
  end
  
  def create_draft
    if @auction.draft!
      redirect_to @auction
    else
      redirect_to home
    end
  end

  private

  def find_auction
    @auction = Auction.find params[:auction_id]
  end

end
