class BooksController < ApplicationController
  def index
    @new_book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user =User.find(@book.user_id)
  end

  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    book.save
    redirect_to book_path(book.id)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def book_params
    params.require(:book).permit(:title, :opinion)
  end
end
