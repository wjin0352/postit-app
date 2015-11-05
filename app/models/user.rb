class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false # we want to manage our own validations! so false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: { minimum: 3 }

  # to specify variable slug attribute in module as name
  sluggable_column :username

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator'
  end

  def two_factor_auth?
    !self.phone.blank?
  end

  def create_pin!
    self.update_column(:pin, rand(10 ** 6)) # random 6 digit num
  end

  def destroy_pin!
    self.update_column(:pin, nil)
  end

  def send_pin_to_twillio!
    # put your own credentials here
    account_sid = 'ENV["ACCOUNT_SID"]'
    auth_token = 'ENV["AUTH_TOKEN"]'

    # set up a client to talk to the Twilio REST API

    @client = Twilio::REST::Client.new account_sid, auth_token

    @client.account.messages.create({
      :from => '+13474427964',
      :to => '#{self.phone}',
      :body => 'Hi, please enter your pin to continue with login: #{self.pin}',
    })

  end

end
