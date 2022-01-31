class SellersController < ApplicationController
  before_action :set_seller, only: %i[ show edit update destroy ]
  before_action :find_product_by_seller, only: %i[ show_product edit_product update_product destroy_product ]

  # GET /sellers or /sellers.json
  def index
    redirect_to seller_home_path
  end

  def list_products
    puts "params.inspect: #{params.inspect}"
    seller_id = params[:id]

    read_seller_with_tenant do
      @products = Product.where(seller_id: seller_id)
    end
  end

  def show_product
    puts "params.inspect: #{params.inspect}"
    puts "@product.inspect: #{@product.inspect}"
    read_seller_with_tenant do
      @product = Product.find(params[:id])
    end
  end

  def new_product
    puts "params.inspect: #{params.inspect}"
    puts "request.subdomain: #{request.subdomain}"
    puts "request.subdomain == 'seller': #{request.subdomain == 'seller'}"
    write_to_seller_with_tenant do
      @product = Product.new(seller_id: params[:seller_id])
    end
  end

  def create_product
    puts "params.inspect: #{params.inspect}"

    write_to_seller_with_tenant do
      @product = Product.new(seller_id: params[:seller_id])
    end

    respond_to do |format|
      if @seller.save
        format.html { redirect_to seller_products_path(@seller, subdomain: 'seller'), notice: "Seller was successfully created." }
        format.json { render :show, status: :created, location: @seller }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  def home
    @sellers = Seller.all
    puts "request.subdomain: #{request.subdomain}"
    puts "Client.where(type: 'Seller'): #{Client.where(type: 'Seller').as_json}"
  end

  # GET /sellers/1 or /sellers/1.json
  def show
    @seller_id = @seller.id
    read_seller_with_tenant do
      @seller_products = Product.where(seller_id: @seller_id)
    end
  end

  # GET /sellers/new
  def new
    puts "request.subdomain: #{request.subdomain}"
    puts "request.subdomain == 'seller': #{request.subdomain == 'seller'}"
    write_to_default_with_tenant do
      @seller = Seller.new(type: "#{request.subdomain == 'seller' ? 'Seller' : 'Buyer'}", name: 'Seller 10')
    end
  end

  # GET /sellers/1/edit
  def edit
  end

  def edit_product
  end

  # POST /sellers or /sellers.json
  def create
    write_to_default_with_tenant do
      @seller = Seller.new(seller_params)
    end

    respond_to do |format|
      if @seller.save
        format.html { redirect_to seller_url(@seller, subdomain: 'seller'), notice: "Seller was successfully created." }
        format.json { render :show, status: :created, location: @seller }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sellers/1 or /sellers/1.json
  def update
    respond_to do |format|
      if @seller.update(seller_params)
        format.html { redirect_to seller_url(@seller), notice: "Seller was successfully updated." }
        format.json { render :show, status: :ok, location: @seller }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_product
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to show_product_seller_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sellers/1 or /sellers/1.json
  def destroy
    @seller.destroy

    respond_to do |format|
      format.html { redirect_to sellers_url, notice: "Seller was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def destroy_product
    write_to_seller_with_tenant do
      @product.destroy
    end

    respond_to do |format|
      format.html { redirect_to list_products_seller_url, notice: "Seller product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seller
      @seller = Seller.find(params[:id])
    end

    def find_product_by_seller
      read_seller_with_tenant do
        @product = Product.find_by(id: params[:id], seller_id: params[:seller_id])
        puts "@product.inspect: #{@product.inspect}"
      end
    end

    # Only allow a list of trusted parameters through.
    def seller_params
      params.require(:seller).permit(:slug, :name, :emails, :password, :type)
    end
end
