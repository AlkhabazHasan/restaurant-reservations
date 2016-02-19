class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  belongs_to :restaurant, -> { where(:role => "manager") }
  has_many :friends, -> { where(:role => "guest") }, :class_name => "User"

  before_create :set_role

  def admin?
    self.role == "admin"
  end

  def guest?
    self.role == "guest"
  end

  def manager?
    self.role == "manager"
  end

  private

  def set_role
    self.role ||= "guest"
  end

end
