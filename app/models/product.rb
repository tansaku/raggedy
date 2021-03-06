class Product < ActiveRecord::Base
	belongs_to :sub_category
	belongs_to :sub_size
	belongs_to :user
	has_many :comments
	has_many :likes, counter_cache: true
	has_and_belongs_to_many :carts
	has_and_belongs_to_many :orders


	
	validates :title, presence: true,
                    length: { minimum: 3 }
    has_attached_file :image, styles: {thumb: '208 x 294>'},
								storage: :s3,
								bucket: 'raggedy_development'


	scope :sold, -> { where(sold: true) }
	scope :unsold, -> { where(sold: false) }
	scope :cheaper_than, ->(amount) { where('asking_price < ?', amount) }
	scope :more_expensive_than, ->(amount) { where('asking_price > ?', amount) }

	# def self.sold
	# 	all.select(&:sold?)
	# end 

	# def self.unsold
	# 	all.reject(&:sold?)
	# end 
	
	def discount 
	  discount = ((1-(asking_price/original_price))*100).to_i
	  "#{discount}%"
	end 
end

