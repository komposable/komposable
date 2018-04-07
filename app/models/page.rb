class Page < ApplicationRecord
  belongs_to :pageable, polymorphic: true

  validates :internal_name, presence: true

  accepts_nested_attributes_for :pageable

  def build_pageable(params)
    self.pageable = pageable_type.constantize.instance
    self.pageable.update(params)
  end

  # Friendly ID
  extend FriendlyId
  friendly_id :internal_name, use: :slugged

  # CMS
  def permitted_attributes
    [:title, :description, pageable_attributes: pageable.class.permitted_attributes]
  end

  delegate :to_frontend_url, to: :pageable
end
