class PagesController < ApplicationController
  def index
    # @users = User.where(id: current_user.id).where.not(image: nil)
    # @users = User.where.not(image: nil)
    # @reviews = Review.last(6)
    @reviews = Review.includes(:user).last(6)
    # @books = Book.
  end

  def show

  end
end
