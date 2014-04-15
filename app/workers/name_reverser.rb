class NameReverser
  @queue = :my_queue
  def self.perform(user_id)
    user = User.find(user_id)
    user.update_attribute(:name, user.name.reverse)
  end
end
