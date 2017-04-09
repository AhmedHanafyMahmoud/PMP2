class ChargesController < ApplicationController
	def new
	end

	def create
	  @amount = params[:amount]
	  @amount = @amount.gsub('$', '').gsub(',', '')
	  @order = Order.find(params[:orderId])
	  
	    @amount = Float(@amount).round(2)
	    @amount = (@amount * 100).to_i # Must be an integer!
	  begin
	  Stripe::Charge.create(
	    :amount => @amount,
	    :currency => 'usd',
	    :source => params[:stripeToken],
	    :description => 'Site order'
	  )
	  @order.status = "paid"
	  @order.save
	  rescue Stripe::CardError => e
	    flash[:error] = e.message
	    @order.status = "unpaid"
	  	@order.save
	    redirect_to @order
	   return
	  end

	end


end
