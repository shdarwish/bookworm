class BookstoresController < ApplicationController
  before_action :set_bookstore, only: [:show, :edit, :update, :destroy]
  before_action :admin_only
  # GET /bookstores
  def index
    @bookstores = Bookstore.all
  end

  # GET /bookstores/1
  def show
  end

  # GET /bookstores/new
  def new
    @bookstore = Bookstore.new
  end

  # GET /bookstores/1/edit
  def edit
  end

  # POST /bookstores
  def create
    @bookstore = Bookstore.new(bookstore_params)

    if @bookstore.save
      redirect_to @bookstore, notice: 'Bookstore was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /bookstores/1
  def update
    if @bookstore.update(bookstore_params)
      redirect_to @bookstore, notice: 'Bookstore was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /bookstores/1
  def destroy
    @bookstore.destroy
    redirect_to bookstores_url, notice: 'Bookstore was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookstore
      @bookstore = Bookstore.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bookstore_params
      params.require(:bookstore).permit(:name)
    end
end
