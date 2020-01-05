class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    email.eql?('admin@gmail.com')
  end

  def archers?
    email.eql?('archers.lonescouts@gmail.com')
  end

  def chevaliers?
    email.eql?('chevaliers.lonescouts@gmail.com')
  end

  def gueux?
    email.eql?('gueux.lonescouts@gmail.com')
  end

  def hardis?
    email.eql?('hardis.lonescouts@gmail.com')
  end

  def paladins?
    email.eql?('paladins.lonescouts@gmail.com')
  end

  def preux?
    email.eql?('preux.lonescouts@gmail.com')
  end

  def servants?
    email.eql?('servants.lonescouts@gmail.com')
  end

  def templiers?
    email.eql?('templiers.lonescouts@gmail.com')
  end

  def vaillants?
    email.eql?('vaillants.lonescouts@gmail.com')
  end
end
