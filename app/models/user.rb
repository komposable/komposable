class User < Komposable::ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  enum role: { owner: 0, admin: 1, editor: 2, user: 3 }

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def self.authorized_roles(current_user)
    return nil unless current_user.owner? || current_user.admin?

    return roles.except(:owner) unless current_user.owner?

    roles
  end
end
