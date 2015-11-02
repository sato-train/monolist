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
    @haved_users = Have.joins(:user).where(:item_id=>@item).map(&:user)
    @wanted_users = Want.joins(:user).where(:item_id=>@item).map(&:user)
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
end
