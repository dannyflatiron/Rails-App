class Mission < ApplicationRecord
  belongs_to :user #gives the reader and writer method
  # belongs_to :category
  has_many :messages
  has_many :users, through: :messages #gives only the writer method for the plural 
  validates :content, :title, presence: true

  scope :alphabetical_order, -> { order(:title)}
  scope :with_long_title, ->(length = 20) { where("LENGTH(title) > ?", length) }




  # makes more sense to use find or create by instead of first or create
  # since first or create is typically used when paramaters are already present
  def category_attributes(attr)
    self.category = Category.find_or_create_by(attr) if !attr[:name].blank?
  end
end
