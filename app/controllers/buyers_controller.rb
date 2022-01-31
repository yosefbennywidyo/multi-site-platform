class BuyersController < ApplicationController
  before_action :set_buyer, only: %i[ show edit update destroy ]

  # GET /buyers or /buyers.json
  def index
    redirect_to buyer_home_path
  end

  def home
    @buyers = Buyer.all
    puts "request.subdomain: #{request.subdomain}"
  end

  # GET /buyers/1 or /buyers/1.json
  def show
  end

  # GET /buyers/new
  def new
    @buyer = Buyer.new
  end

  def new_order
    puts "new_order params.inspect: #{params.inspect}"
    @buyer = Buyer.find(params[:client_id])

    puts "@buyer.inspect: #{@buyer.inspect}"
    write_to_default_with_tenant do
      @order = Order.new(buyer_id: params[:client_id])
    end

    read_seller_with_tenant do
      @products = JSON.parse(Product.all.pluck(:name, :id).to_json)
    end
  end

  def get_price
    puts "get_price params.inspect: #{params.inspect}"
    respond_to do |format|
      format.turbo_stream
    end
  end

  # GET /buyers/1/edit
  def edit
  end

  # POST /buyers or /buyers.json
  def create
    @buyer = Buyer.new(buyer_params)

    respond_to do |format|
      if @buyer.save
        format.html { redirect_to buyer_url(@buyer), notice: "Buyer was successfully created." }
        format.json { render :show, status: :created, location: @buyer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @buyer.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_order
    puts "create_order params.inspect: #{params.inspect}"
    @buyer = Buyer.find(params[:client_id])

    puts "@create_order buyer.inspect: #{@buyer.inspect}"

    write_to_default_with_tenant do
      @order = Order.new(buyer_params)
    end

    puts "create_order @order.inspect: #{@order.inspect}"

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buyers/1 or /buyers/1.json
  def update
    respond_to do |format|
      if @buyer.update(buyer_params)
        format.html { redirect_to buyer_url(@buyer), notice: "Buyer was successfully updated." }
        format.json { render :show, status: :ok, location: @buyer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @buyer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buyers/1 or /buyers/1.json
  def destroy
    @buyer.destroy

    respond_to do |format|
      format.html { redirect_to buyers_url, notice: "Buyer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buyer
      @buyer = Buyer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def buyer_params
      params.require(:buyer).permit(:slug, :name, :emails, :password, :type)
    end
end
