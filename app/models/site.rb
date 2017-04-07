class Site < ApplicationRecord


	validates :name, :address, :price, :displayNumber, presence: true
    validates :price, numericality: {
    	only_integer: true,
   	    greater_than_or_equal_to: 0,
    	message: "can only be a whole number > 0"
	}
    validates :displayNumber, numericality: {
    	only_integer: true,
   	    greater_than_or_equal_to: 0,
    	message: "can only be a whole number > 0"
	}
    has_many :orders , dependent: :destroy

end
