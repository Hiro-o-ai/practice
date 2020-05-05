class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    if @comment.save
      redirect_to book_path(@book)
    else
      @bookn = Book.new
      @user = @book.user
      @book_comment = @book.book_comments
      render '/books/show'
    end
  end

  def destroy
    comment = BookComment.find(params[:id])
    comment.destroy
    redirect_back(fallback_location: root_url)
  end

  private
    def book_comment_params
      params.require(:book_comment).permit(:comment)
    end

end