require_relative '../helpers/image_upload'

class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :location

  has_many :recipient

  validates :user, :category, :location, presence: true
  validates :description, length: {maximum: 500}

  before_create :generate_uuid

  @fields_that_require_auth = %w(user_uuid updated_at sent_at)

  def self.json(authorised, confirmed = false)
    result = []
    Report.all.each do |report|
      if !confirmed || (confirmed && report.user.confirmed)
        reportHash = JSON.parse(report.to_json)
        reportHash.delete('id')
        Category.ID_to_name_hash(reportHash, report['category_id'])
        User.ID_to_UUID_hash(reportHash, report['user_id'])
        Location.object_to_lat_long_address(reportHash, report['location_id'])

        unless authorised
          reportHash = reportHash.reject { |key| @fields_that_require_auth.include?(key) }
        end
        result.push(reportHash)
      end
    end
    return result.to_json
  end

  def as_csv
    return [self.user.uuid, self.location.formatted_address, self.location.lat, self.location.long, self.category.name, self.description, self.image, self.created_at, self.sent_at].to_csv
  end


  def self.export
    result = %w(user_uuid address latitude longitude category description image created_at sent_at).to_csv
    Report.all.each do |report|
      result+=(report.as_csv) if report.user.confirmed?
    end
    return result
  end


  def generate_uuid
    self.uuid = SecureRandom.uuid

    unless image.nil?
      url = ImageUpload.upload_base64(image, uuid)
      self.image = url
    end
  end

  def requires_auth?(field)
    # @fields_that_require_auth.include?(field)
    [:user, :category].include?(field)
  end
end
