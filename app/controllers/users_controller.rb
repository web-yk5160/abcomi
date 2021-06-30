class UsersController < ApplicationController
  before_action :sign_in_required, only: %i[show following followers]

  def index; end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @expected_country = @user.study_abroad_expectations
    @target_country = @user.study_abroad_targets
  end

  def following
    @title = 'がフォローしているユーザー'
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = 'をフォローしているユーザー'
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end
end
