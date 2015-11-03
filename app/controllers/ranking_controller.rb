class RankingController < ApplicationController

  def have

    haves = Have.group(:item_id).order('count_item_id desc').limit(10).count(:item_id)
    
    @items = Array.new
    Item.find(haves.keys).sort_by do |h|
      @items << [h,haves[h.id]]
      haves.keys.index(h.id)
    end
  end

  def want

    wants = Want.group(:item_id).order('count_item_id desc').limit(10).count(:item_id)

    @items = Array.new
    Item.find(wants.keys).sort_by do |w|
      @items << [w,wants[w.id]]
      wants.keys.index(w.id)
    end
  end

end
