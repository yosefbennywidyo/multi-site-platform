class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    puts "params.inspect: #{params.inspect}"
    seller_id = params[:seller_id]
    puts "seller_id.inspect: #{seller_id.inspect}"
    read_seller_with_tenant do
      @products = Product.where(seller_id: seller_id)
      puts "@products.length: #{@products.length}"
    end
  end

  # GET /products/1 or /products/1.json
  def show

  end

  # GET /products/new
  def new
    write_with_tenant do
      @product = Product.new(seller_id: params[:seller_id])
    end
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    write_with_tenant do
      @product = Product.new(product_params)
    end

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      read_seller_with_tenant do
        @product = Product.find_by_id(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :slug, :client_id, :seller_id, :buyer_id, :subdomain, :type)
    end
end
