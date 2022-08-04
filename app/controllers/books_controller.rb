class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
    @booknew = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @booknew = Book.new
    @user = @book.user
  end

  def create
    @booknew = Book.new(book_params)
    @booknew.user_id = current_user.id
    if @booknew.save
      redirect_to book_path(@booknew), notice: "You have created a book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "The book has been updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "You have deleted the book successfully."
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end
end
