class BooksController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]

	def top
	end
	
	def about
	end

	def create
		@bookn = Book.new(book_params)
		@bookn.user_id = current_user.id
		if  @bookn.save
			redirect_to book_path(@bookn.id),notice: "Book was successfully created."
		else
      @books = Book.all
			render 'index'
		end
	end

	def index
		@books = Book.all
		@user = User.find(current_user.id)
    @bookn = Book.new
	end

	def show
		@book = Book.find(params[:id])
		@bookn = Book.new
		@user = @book.user
    @comment = BookComment.new
    @book_comment = @book.book_comments
	end

	def edit
	end

	def update
		if 	@book.update(book_params)
			redirect_to book_path(@book.id), notice: "Book was successfully created."
		else
			render :edit
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end
  def correct_user
  	@book = Book.find(params[:id])
  	if 	@book.user_id != current_user.id
  		redirect_to books_path
  	end
  end

end