class RankingController < ApplicationController

  def have
    select_rank("Have")
  end

  def want
    select_rank("Want")
  end
  
  private

  def select_rank (type)
    # select(type,item_id,count(user_id) as users from ownerships where type="Have" group by item_id order by users desc limit 5
    @groups = Ownership.select('item_id as id,count(user_id) as user_count')
              .where('type = ?',type)
              .group('item_id')
              .order('user_count desc')
              .limit(10)
    @result_items = Item.select('id,title,detail_page_url,medium_image').where("id IN (?)", @groups.to_a).to_a
    
    @items = Hash.new
    @result_items.each do |item|
      @items.store( item.id, item)
    end
    
  end
end
