class UsersController < ApplicationController
  before_action :sign_in_required

  def index
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end
end
