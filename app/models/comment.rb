class Comment < ApplicationRecord
	belongs_to :user
    belongs_to :post
    validates :comment_content, length: { in: 1..50 } 
end
