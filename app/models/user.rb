class User < ApplicationRecord
  has_many :shifts
  has_many :shows, through: :shifts
  has_many :authorized_jobs
  has_many :jobs, through: :authorized_jobs
  validates_presence_of :name, :email
  validates :name, length: { minimum: 3 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


end
