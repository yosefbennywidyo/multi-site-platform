class ProductDetailsController < ApplicationController
  before_action :set_detail_of_current_product, only: %i[ show edit update destroy ]

  # GET /detail_of_current_products or /detail_of_current_products.json
  def index
    @detail_of_current_products = ProductDetail.all
  end

  # GET /detail_of_current_products/1 or /detail_of_current_products/1.json
  def show
  end

  # GET /detail_of_current_products/new
  def new
    @detail_of_current_product = ProductDetail.new
  end

  # GET /detail_of_current_products/1/edit
  def edit
  end

  # POST /detail_of_current_products or /detail_of_current_products.json
  def create
    @detail_of_current_product = ProductDetail.new(detail_of_current_product_params)

    respond_to do |format|
      if @detail_of_current_product.save
        format.html { redirect_to detail_of_current_product_url(@detail_of_current_product), notice: "Detail of current product was successfully created." }
        format.json { render :show, status: :created, location: @detail_of_current_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @detail_of_current_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /detail_of_current_products/1 or /detail_of_current_products/1.json
  def update
    respond_to do |format|
      if @detail_of_current_product.update(detail_of_current_product_params)
        format.html { redirect_to detail_of_current_product_url(@detail_of_current_product), notice: "Detail of current product was successfully updated." }
        format.json { render :show, status: :ok, location: @detail_of_current_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @detail_of_current_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /detail_of_current_products/1 or /detail_of_current_products/1.json
  def destroy
    @detail_of_current_product.destroy

    respond_to do |format|
      format.html { redirect_to detail_of_current_products_url, notice: "Detail of current product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_detail_of_current_product
      @detail_of_current_product = ProductDetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def detail_of_current_product_params
      params.require(:detail_of_current_product).permit(:product_id, :quantity, :price)
    end
end
