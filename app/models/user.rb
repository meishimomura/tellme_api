# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  self.primary_key = :uid

  belongs_to :school
  belongs_to :group
  has_many :notifications, dependent: :destroy, inverse_of: 'user', foreign_key: :uid
  has_many :notification_checks, dependent: :destroy, inverse_of: 'user', foreign_key: :uid
  has_many :course_directors, dependent: :destroy, inverse_of: 'user', foreign_key: :uid
  has_many :comments, dependent: :destroy, inverse_of: 'user', foreign_key: :uid
  has_many :votes, dependent: :destroy, inverse_of: 'user', foreign_key: :uid
end
