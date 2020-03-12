class CartItemsController < ApplicationController

before_action :authenticate_user!

  def index 
    @cart_items = CartItem.all
  end


  def show
  end

  def create 
    @cart = Cart.find_by(user: current_user)
    @item = Item.find_by(id: params[:item_id])
    @cart_item = CartItem.new(cart: @cart, item: @item)
      if @cart_item.save 

      redirect_to root_path
      flash[:alert] = "L'article a bien été ajouté au panier"
      else

      flash[:error] = 'Le produit n\'a pas été ajouté à votre panier'
      redirect_to items_path
      end
  end

  def destroy
    @cart = Cart.where(user_id: current_user.id).first
    @cart_item_id = @cart_item.id
    @cart_item.destroy
    respond_to do |format|
      format.html { }
      format.js { }
    end
  end


end
