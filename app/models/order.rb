class Order < ApplicationRecord
    validates :address, :phone, :period, :frequency, :start_date, :post_id, :site_id,  presence: true
    validates :frequency, numericality: {
    	only_integer: true,
   	    greater_than_or_equal_to: 1,
   	    less_than_or_equal_to: 12,
    	message: "(per hour) can only be a whole number between 1 and 12"
	}
      validates :period, numericality: {
      only_integer: true,
        greater_than_or_equal_to: 1,
        less_than_or_equal_to: 16,
      message: "(in weeks) can only be a whole number between 1 and 16"
  }
  validates_date :start_date, :on_or_after => (Date.today + 2)
  # validate :expiration_date_cannot_be_in_the_past
  # def expiration_date_cannot_be_in_the_past
  #   unless ((:start_date.year * 365 + :start_date.month * 30 + :start_date.day ) > ((Date.today + 1).year*365+(Date.today + 1).month*30+(Date.today + 1).day))  
  #     errors.add(:expiration_date, "can't be before 2 days from now")
  #   end
  # end    

	  belongs_to :user
    belongs_to :post
    belongs_to :site

end
