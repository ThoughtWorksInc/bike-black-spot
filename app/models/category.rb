require 'json'

class Category < ActiveRecord::Base
  has_many :reports
  before_create :generate_uuid

  validates :name, presence: true

  def self.json
    result = []
    Category.all.each do |category|
      result.push(name: category[:name])
    end
    result.to_json
  end

  def self.ID_to_name_hash(hash, id)
    hash.delete('category_id')
    hash['category'] = (Category.find(id)).name
  end

  private
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
	
