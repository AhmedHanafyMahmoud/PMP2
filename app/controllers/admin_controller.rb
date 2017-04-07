class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user
  
  def edit_user
  	@user=User.find(params[:param1])
  	@user.is_locked=not(@user.is_locked)
  	@user.save
  	redirect_to allusers_path
  end

  def edit_order
    @order=Order.find(params[:param1])
    @order.status=params[:param2]
    @order.save
    redirect_to orders_path
  end

  def check_user
      unless (current_user.is_admin?)
        redirect_to root_url, alert: "You have no admin righs!"
      end
    end
end
