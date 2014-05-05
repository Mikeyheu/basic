class NameReverser
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    user.update_attribute(:name, user.name.reverse)
  end
end
