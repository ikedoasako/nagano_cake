class Item < ApplicationRecord

  has_one_attached :image
  has_many :cart_items, dependent: :destroy

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  ## 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end
  
  ## 小計を求めるメソッド
  def subtotal
    item.with_tax_price * amount
  end
  
  ##カートの合計の算出
  def total_price
    items.sum("quantity*price")
  end

end