class ReviewsController < ApplicationController
  before_action :set_review, only: %i[update destroy]

  def new
    @review = Review.new
  end

  def create

    @beer = Beer.find(params[:beer_id]) # Getting beer from params which is coming from beers#show when clicking on submit edit
    @review = Review.new(review_params)
    @review.user = current_user
    @review.beer = @beer
    @review.rate = 0 unless @review.rate
    if @review.save
      redirect_to beer_path(@beer), notice: 'Review sucessfully created'
    else
      render 'beers#show'
    end

  end

  def edit
    @beer = Beer.find(params[:beer_id])
    @review = Review.where(beer_id: @beer.id, user_id: current_user.id).first
  end

  def update

    if @review.save
      @review.update(review_params)
      @beer = @review.beer
      redirect_to beer_path(@beer), notice: 'Review sucessfully updated'
    else
      render :edit
    end

  end

  def destroy
    @beer = @review.beer
    @review.destroy

    redirect_to beer_path(@beer), notice: 'Review sucessfully deleted'
  end

  private

  def set_review
     @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rate, :comment)
  end
end
