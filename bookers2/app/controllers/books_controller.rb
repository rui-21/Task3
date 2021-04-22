class BooksController < ApplicationController
  def index
    @book = Book.new
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
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(book.id), notice: 'You have created book successfully.'
    else
      @new_book = Book.new
      @books = Book.all
      @user = User.find(current_user.id)
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    end
      redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    Book.find_by(id: params[:id]).destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :opinion)
  end
end
