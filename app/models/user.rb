class User < ApplicationRecord
  EMAIL_FORMAT = /\A[^@\s]+@[^@\s]+\z/.freeze
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fill: [60, nil]
  end

  validates(
    :email,
    presence: true,
    uniqueness: true,
    format: { with: EMAIL_FORMAT }
  )
end
