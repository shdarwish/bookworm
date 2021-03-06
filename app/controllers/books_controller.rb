class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :admin_only, only: [:edit, :new, :update, :create, :destroy]
  autocomplete :book, :title, :full => true
  before_action :admin_only, only: [:create, :edit, :update, :destroy]


  # GET /books
  def index
   # @books = Book.where(["title LIKE ?", "%#{params[:search]}%"]).order(count: :desc)
      @books = Book.all
     if params[:search]
      @books = Book.name_like("%#{params[:search]}%").order('name')
    else
    end
  end

  def reco_book
    if current_user.genres.to_a.size <= 0
      @books = Book.all
    else 
      @books = Book.genrecheck(current_user.id)
    end
  end

  # GET /books/1
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
      @book.authors = Author.find(params[:author_ids])
      @book.bookstores = Bookstore.find(params[:bookstore_ids])
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
      @book.authors = Author.find(params[:author_ids])
      @book.bookstores = Bookstore.find(params[:bookstore_ids])
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      params.require(:book).permit(:isbn, :title, :genre_id, :bookimage, :description)
    end
end
