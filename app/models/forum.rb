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
end
