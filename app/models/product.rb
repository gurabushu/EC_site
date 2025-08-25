class Product < ApplicationRecord
    has_many :cart_items, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :order_items, dependent: :destroy
    
    validates :title, presence: true
    validates :price, numericality: { only_integer: true, greater_than: 0}
    validates :stock, numericality: {only_integer: true, greater_than_or_equal_to: 0} 
    validates :price, presence: true
    validates :description, presence: true
    validates :stock, presence: true
    validates :description, length: {maximum: 500}


    
    def in_stock?
        stock > 0
    end
end
