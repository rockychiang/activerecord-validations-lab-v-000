class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: {minimum: 250}
  validates :summary, length: {maximum: 250}
  validates :category, inclusion: {in: %w(Fiction Non-Fiction)}
  validate :clickbait?

  private

  def clickbait?
    cb = ["Won't Believe", "Secret", "Top", "Guess"].map do |phrase|
      title.include?(phrase) ? true : false
    end
    if title.present? && !cb.include?(true)
      errors.add(:title, "Not clickbait-y")
    end
  end
end
