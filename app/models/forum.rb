class Forum < ApplicationRecord
  belongs_to :customer
  has_many :attentions, dependent: :destroy
  has_many :attentioned_customers, through: :attentions, source: :customer
  has_many :forum_comments, dependent: :destroy
  has_many :forum_reports, dependent: :destroy
  has_many :forum_reported_customers, through: :forum_reports, source: :customer

  def attentioned_by?(customer)
    attentions.exists?(customer_id: customer.id)
  end

  def forum_reported_by?(customer)
    forum_reports.exists?(customer_id: customer.id)
  end

  def self.forum_attentions
    Forum.includes(:attentioned_customers).sort { |a, b| b.attentioned_customers.size <=> a.attentioned_customers.size }
  end

  def self.forum_week_attentions
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    Forum.includes(:attentioned_customers).sort do |a, b|
      b.attentioned_customers.includes(:attentions).where(attentions: { created_at: from...to }).size <=>
        a.attentioned_customers.includes(:attentions).where(attentions: { created_at: from...to }).size
    end
  end

  def self.forum_reports
    Forum.includes(:forum_reported_customers).sort { |a, b| b.forum_reported_customers.size <=> a.forum_reported_customers.size }
  end
end
