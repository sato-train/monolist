class Item < ActiveRecord::Base
  serialize :raw_info , Hash
  attr_accessor :user_count

  has_many :ownerships, foreign_key: "item_id", dependent: :destroy
  has_many :users, through: :ownerships

  #want_usersとの仮想的な中間テーブルとなる
  has_many :wants, foreign_key: "item_id", dependent: :destroy
  #Itemをwantしたユーザーの一覧。wantsを用いて取得する
  has_many :want_users, through: :wants, source: :user

  #have_usersとの仮想的な中間テーブルとなる	外部キーとしてitem_idを用いる
  has_many :haves, foreign_key: "item_id", dependent: :destroy
  #Itemをhaveしたユーザーの一覧。havesを用いて取得する	source: :userを用いる
  has_many :have_users, through: :haves, source: :user
end
