class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates :user_id, :video_id, presence: true

  #little unnecessary
  before_save :liked_or_loved

  def liked_or_loved
    unless self.like || self.love
      errors.add(:love, "Vote must be liked or loved")
    end
  end

end