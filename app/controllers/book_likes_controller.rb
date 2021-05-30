class BookLikesController < ApplicationController
  before_action :book_params

  def create
    BookLike.create(user_id: current_user.id, book_id: params[:id])
  end

  def destroy
    BookLike.find_by(user_id: current_user.id, book_id: params[:id]).destroy
  end

  private

  def book_params
    @book = Book.find(params[:id])
  end
end
