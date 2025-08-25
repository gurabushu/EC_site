class Product < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :order_items, dependent: :destroy

  validates :title,       presence: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :stock,       presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price,       presence: true, numericality: { greater_than: 0 }

  private

  def in_stock?
    stock > 0
  end
end