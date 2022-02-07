class ClientsController < ApplicationController
  before_action :authorized, only: %i[ show edit update destroy ]
  before_action :set_client, only: %i[ show edit update destroy ]
  before_action :current_client_shopping_cart, only: %i[ products_list shopping_cart add_to_shopping_cart remove_from_shopping_cart check_product_in_cart ]
  before_action :current_client_enqueue_cart, only: %i[ products_list enqueue_cart add_to_enqueue_cart remove_from_enqueue_cart check_product_in_cart ]
  before_action :require_login, only: %i[ shopping_cart ]
  before_action :permit_params, only: %i[ add_to_shopping_cart remove_from_shopping_cart checkout_cart add_to_enqueue_cart remove_from_enqueue_cart ]

  # GET /clients or /clients.json
  def index
    @clients = Client.all
  end

  # GET /clients/1 or /clients/1.json
  def show
  end

  def current_client_shopping_cart
    set_current_client_cart
  end

  def set_current_client_cart(shopping=true)
    if shopping && logged_in?
      @shopping_cart = ShopCart.where('transaction_id is null').where(client_id: @current_client.id).try(:last)
      @shopping_cart = ShopCart.create(client_id: @current_client.id) unless @shopping_cart.present?
    elsif !shopping && logged_in?
      @enqueue_cart = QueueCart.where('transaction_id is null').where(client_id: @current_client.id).try(:last)
      @enqueue_cart = QueueCart.create(client_id: @current_client.id) unless @enqueue_cart.present?
    end
  end

  def current_client_enqueue_cart
    set_current_client_cart(false)
  end

  def products_list
    read_seller_with_tenant do
      @products = Product.all
    end
  end

  def add_to_shopping_cart
    check_product_in_cart
    if @product_in_shopping_cart.present?
      @product_in_shopping_cart.update(quantity: @product_in_shopping_cart.quantity += 1)
    else
      @shopping_cart.products_shopping_carts.create(product_id: params[:product_id], quantity: 1, price: read_seller_with_tenant { ProductDetail.find_by_product_id(params[:product_id]).price }, discount: 0)
    end
    flash[:info] = "Product added to Cart"
  end

  def check_product_in_cart(shopping = true)
    if shopping && @shopping_cart.products_shopping_carts.present?
      @product_in_shopping_cart = @shopping_cart.products_shopping_carts.find_by(product_id: params[:product_id])
    elsif !shopping && @enqueue_cart.products_shopping_carts.present?
      @product_in_enqueue_cart = @enqueue_cart.products_shopping_carts.find_by(product_id: params[:product_id])
    else
      @product_in_shopping_cart = nil
    end
  end

  def remove_from_shopping_cart
    check_product_in_cart
    if @product_in_shopping_cart.present?
      @product_in_shopping_cart.update(quantity: @product_in_shopping_cart.quantity -= 1) if @product_in_shopping_cart.quantity > 0
      @product_in_shopping_cart.destroy if @product_in_shopping_cart.quantity == 0
    end
  end

  def shopping_cart
    if @shopping_cart.present?
      @products_shopping_cart = ProductsShoppingCart.where(shopping_cart_id: @shopping_cart.id).pluck(:product_id, :quantity, :price, :discount)
      
      read_seller_with_tenant do
        @products_shopping_cart.each_with_index do |element, index|
          element << Product.find_by(id: element[0]).name
          element << Product.find_by(id: element[0]).seller_id
        end
      end

      @total_price = 0
      
      @products_shopping_cart_hash = []
      @products_shopping_cart.each_with_index do |element, index|
        @products_shopping_cart_hash.push({product_id: element[0], name: element[4], quantity: element[1], price: element[2], discount: element[3], buyer_id: @current_client.id, seller_id: element[5], total: element[1] * element[2]})
      end
    end
  end

  def enqueue_cart
    if @enqueue_cart.present?
      @products_enqueue_cart = ProductsShoppingCart.where(shopping_cart_id: @enqueue_cart.id).pluck(:product_id, :quantity, :price, :discount)
      
      read_seller_with_tenant do
        @products_enqueue_cart.each_with_index do |element, index|
          element << Product.find_by(id: element[0]).name
          element << Product.find_by(id: element[0]).seller_id
        end
      end

      @total_price = 0
      @products_enqueue_cart_hash = []

      @products_enqueue_cart.each_with_index do |element, index|
        @products_enqueue_cart_hash.push({product_id: element[0], name: element[4], quantity: element[1], price: element[2], discount: element[3], buyer_id: @current_client.id, seller_id: element[5], total: element[1] * element[2]})
      end
    end
  end


  def checkout_cart
    params_json_parse = JSON.parse(params[:product_id])
    order = params_json_parse.last['order']
    params_json_parse.last.delete('order')
    generate_bill_number
    params_json_parse.each do |element|
      if order && element.length > 1
        @parent_order = OrderTransaction.create(bill_number: @bill_number, buyer_id: element['buyer_id'], seller_id: element['seller_id']) unless OrderTransaction.find_by_bill_number(@bill_number).present?
        new_order = OrderTransaction.create(element.except('name').merge!(bill_number: @parent_order.bill_number, parent_id: @parent_order.id))    
      elsif !order && element.length > 1
        @parent_enqueue = QueueTransaction.create(bill_number: @bill_number, buyer_id: element['buyer_id'], seller_id: element['seller_id']) unless OrderTransaction.find_by_bill_number(@bill_number).present?
        new_enqueue = QueueTransaction.create(element.except('name').merge!(bill_number: @parent_enqueue.bill_number, parent_id: @parent_enqueue.id))
      end
    end
    
    flash[:info] = "Shopping Cart Checked Out"
  end

  def generate_bill_number
    @bill_number = SecureRandom.urlsafe_base64(24)
  end

  def add_to_enqueue_cart
    check_product_in_cart(false)
    
    if @product_in_enqueue_cart.present?
      @product_in_enqueue_cart.update(quantity: @product_in_enqueue_cart.quantity += 1)
    else
      @enqueue_cart.products_shopping_carts.create(product_id: params[:product_id], quantity: 1, price: read_seller_with_tenant { ProductDetail.find_by_product_id(params[:product_id]).price }, discount: 0)
    end
    flash[:info] = "Product enqueued to Cart"
  end

  def remove_from_enqueue_cart
    check_product_in_cart(false)
    if @product_in_enqueue_cart.present?
      @product_in_enqueue_cart.update(quantity: @product_in_enqueue_cart.quantity -= 1) if @product_in_enqueue_cart.quantity > 0
      @product_in_enqueue_cart.destroy if @product_in_enqueue_cart.quantity == 0
    end
  end

  # GET /clients/new
  def new
    @client = Client.new(type: "#{request.subdomain == 'seller' ? 'Seller' : 'Buyer'}")
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients or /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.valid?
        format.html { redirect_to client_url(@client), notice: "Client was successfully created." }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1 or /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to client_url(@client), notice: "Client was successfully updated." }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1 or /clients/1.json
  def destroy
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url, notice: "Client was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.require(:client).permit(:slug, :name, :email, :password, :type, :password_confirmation, :product_id)
    end

    def permit_params
      params.permit!
    end
end
