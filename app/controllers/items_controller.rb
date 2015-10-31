class ItemsController < ApplicationController
  before_action :logged_in_user , except: [:show]
  before_action :set_item, only: [:show]

  def new
    if params[:q]
      response = Amazon::Ecs.item_search(params[:q] , 
                                  :search_index => 'All' , 
                                  :response_group => 'Medium' , 
                                  :country => 'jp')
      @amazon_items = response.items
    end
  end

  def show
    @user_ids = Ownership.where( item_id: @item.id, type:"Have");
    @haved_users = User.where("id IN (?)", @user_ids.to_a)
    
    @user_ids = Ownership.where( item_id: @item.id, type:"Want");
    @wanted_users = User.where("id IN (?)", @user_ids.to_a)
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
end
