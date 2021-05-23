class ReviewsController < ApplicationController
    before_action :authenticate_user!

    def create 
        @book = Book.find(params[:book_id])
        @review = @book.reviews.build(review_params)
        @review.user = current_user
        if @review.save
            redirect_to @book 
        else 
            redirect_to @book
        end
    end

    private
    
    def review_params
        params.require(:review).permit(:title, :content, :rate)
    end
end
