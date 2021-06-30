class BooksController < ApplicationController
  before_action :sign_in_required
  before_action :sign_in_required, only: [:new, :edit, :update, :destroy]
  before_action :find_books, only: [:show, :edit, :update, :destroy]

  def index
    if params[:q].present?
      @search = Book.ransack
      @search_books = @search.result.page(params[:page]).per(12)
    else
      params[:q] = { sorts: 'id desc' }
      @search = Book.ransack
      @search_books = Book.all.page(params[:page]).per(12)
    end
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
    @book_reviews = @book.reviews.all.page(params[:page]).per(5)
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to @book
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book
    else
      render edit
    end
  end

  def destroy
    @book.destroy
    redirect_to @book.user
  end

  def search 
    @search_books = @q.result.page(params[:page]).per(12)
  end

  private

  def book_params
    params.require(:book).permit(:name, :image, :price, :author, :category, :content, :published_at, :published_by)
  end

  def find_books
    @book = Book.find(params[:id])
  end
end
