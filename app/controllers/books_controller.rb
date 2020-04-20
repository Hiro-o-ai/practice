class BooksController < ApplicationController
  	before_action :authenticate_user!, only: [:index, :show, :edit, :update, :destroy, :create]
  	before_action :correct_user, only: [:edit, :update]
	def top
	end
	
	def about
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if  @book.save
			redirect_to book_path(@book.id),notice: "Book was successfully created."
		else
        	@books = Book.all
			render 'index'
		end
	end

	def index
		@books = Book.all
		@user = User.find(current_user.id)
    	@book = Book.new
	end

	def show
		@book = Book.find(params[:id])
		@book1 = Book.new
		@user = @book.user
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if 	@book.update(book_params)
			redirect_to book_path(@book.id), notice: "Book was successfully created."
		else
			render :edit
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to book_path
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