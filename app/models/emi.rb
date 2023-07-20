class Emi < ApplicationRecord
	belongs_to :loan 
	enum :status, {unpaid: 0,paid: 1}, prefix: true, scopes: false
	
end
