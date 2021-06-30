class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new 
    @book = Book.find(params[:book_id])
    @review = @book.reviews.build
  end

  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      redirect_to book_path(@book)
    else
      redirect_to new_book_review_path(@book), alert: "タイトルとレビュー内容を入力してください。"
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :rate)
  end
end
