class ReviewsController < ApplicationController
  before_action :set_review, only: %i[edit update destroy]

  def new
    @review = Review.new
  end

  def create
    # How to get beer?
    @review = Review.new(review_params)
    @review.user = current_user

    redirect_to review_path(@review), notice: 'Review sucessfully created'
  end

  def edit
  end

  def update
    @review.update(review_params)
    redirect_to review_path(@review), notice: 'Review sucessfully updated'
  end

  def destroy
    @beer = @review.beer
    @review.destroy

    redirect_to beer_path(@beer), notice: 'Review sucessfully deleted'
  end

  private

  def set_review
    @review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rate, :comment)
  end
end
