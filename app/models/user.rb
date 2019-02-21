class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  enum role: { superadmin: 0, admin: 1, editor: 2, user: 3 }

  def full_name
    [first_name, last_name].compact.join(" ")
  end

  # Strong params
  def self.permitted_attributes
    [:email, :first_name, :last_name, :password, :password_confirmation]
  end
end
