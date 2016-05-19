class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def archive!
    # we only archive once and keep this timestamp
    self.update(archived_at: Time.now) unless self.archived_at
  end
end
