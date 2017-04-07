class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_admin, only: [:index]
  before_action :check_status, only: [:edit, :update]
  before_filter :reject_locked!
  before_action :check_hasPosts, only: [:new]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all()
  end

  def purchases
    @orders = Order.where(user_id: current_user.id)
  end
  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    unless(@order.frequency== nil || @order.period==nil || @order.site_id== nil)
      @order.total_price = Site.find(@order.site_id).price * @order.frequency * @order.period 
    else
      @order.total_price = 0
    end
    @order.status = "unpaid"

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:site_id, :post_id, :period, :start_date, :frequency, :address, :phone)
    end

    def check_admin
      unless (current_user.is_admin?)
        redirect_to root_url, alert: "You have no admin righs!"
      end
    end    
    def check_status
      unless (current_user.is_admin? or @order.status=="unpaid")
        redirect_to root_url, alert: "You have no admin righs!"
      end
    end
    def check_hasPosts
      if (Post.where(user_id: current_user.id).length == 0)
        redirect_to new_post_path, alert: "You must creat a media first!"
      end
    end

    def reject_locked!
      if current_user && current_user.is_locked?
        sign_out current_user
        user_session = nil
        current_user = nil
        flash[:alert] = "Your account is locked."
        flash[:notice] = nil
        redirect_to root_url
      end
    end
    helper_method :reject_locked!
end
