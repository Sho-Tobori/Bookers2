class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :corrent_user, only: [:edit, :update]

  def index
    # 部分テンプレート
    @book = Book.new
    @user = current_user
    # ページ内容
    @books = Book.all
    @reservations = Reservation.all
  end

  def create
  @book = Book.new(book_params)
  @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have creatad book successfully"
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    # 部分テンプレート
    @book = Book.new
    # ページ内容
    @books = Book.find(params[:id])
    @user = @books.user
    @post_comment = PostComment.new
  end

	def edit
    	@book = Book.find(params[:id])
  end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
       flash[:notice] = "You have updated user successfully."
		   redirect_to book_path(@book)
    else
      render :edit
    end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title,:body)
	end

private
  def corrent_user
    book = Book.find(params[:id])
      if  current_user.id != book.user_id
          redirect_to books_path
      end
  end
end
