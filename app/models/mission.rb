class Mission < ApplicationRecord
  belongs_to :user #gives the reader and writer method
  belongs_to :category
  has_many :messages, dependent: :delete_all
  has_many :users, through: :messages #gives only the writer method for the plural 
  validates :content, :title, presence: true

  scope :alphabetical_order, -> { order(:title)}
  scope :with_long_title, ->(length = 20) { where("LENGTH(title) > ?", length) }

  delegate :name, to: :category


  # makes more sense to use find or create by instead of first or create
  # since first or create is typically used when paramaters are already present
  def category_attributes=(attr)
    self.category = Category.find_or_create_by(attr) if !attr[:name].blank?
  end

  def self.filter(params)
    where("category_id = ?", params)
  end

  def self.search(params)
    left_joins(:messages).where("LOWER(missions.title) LIKE :term OR LOWER(missions.content) LIKE :term OR LOWER(messages.content) LIKE :term", term: "%#{params}%")
  end


end
