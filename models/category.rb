class Category < ActiveRecord::Base
	has_many :reports
  before_create :generate_uuid

  private
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
	
