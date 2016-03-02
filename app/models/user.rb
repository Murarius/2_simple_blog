class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :rememberable, :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :trackable, :validatable
end
