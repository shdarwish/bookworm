# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Socify is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable
  acts_as_voter
  acts_as_follower
  acts_as_followable

  has_many :usergenres
  has_many :genres, through: :usergenres

  has_many :posts
  has_many :comments
  has_many :events

# i am not sure about this 
  has_many :books, through: :posts

  has_one :prefer

  #has_one :quiz
  has_many :notifications

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, AvatarUploader

  validates :username, presence: true, uniqueness: true
  validates :name, presence: true
 # validates :email, presence: true, uniqueness: true
 # validates :password, presence: true, length: { minimum: 8 }

  self.per_page = 10

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
end
