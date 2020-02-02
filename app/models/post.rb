class Post < ApplicationRecord
	belongs_to :user
	attachment :post_image
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	validates :post_content, presence: true
	
	def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end

    def self.search(search)
		if search
			Post.where(['post_content LIKE ?', "%#{search}%"])
		else
			Post.all
		end
	end

end
