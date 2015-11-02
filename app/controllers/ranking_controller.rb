class RankingController < ApplicationController

  def have
    ids = Have.group(:item_id).order('count_item_id desc').limit(10).count(:item_id)
    @items = Item.find(ids.keys).each do |item|
      item.user_count = ids[item.id]
    end
    @items = @items.sort_by do |item|
      [- item.user_count]
    end
  end

  def want
    ids = Want.group(:item_id).order('count_item_id desc').limit(10).count(:item_id)
    @items = Item.find(ids.keys).each do |item|
      item.user_count = ids[item.id]
    end
    @items = @items.sort_by do |item|
      [- item.user_count]
    end
  end

end
