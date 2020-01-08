namespace :child do
  
  desc "Update all children who don't have a user_facing_id set"
  task :update_user_facing_id => :environment do |_task, args|
    Child.where(user_facing_id: nil).each { |child| child.update_attribute(:user_facing_id, SecureRandom.uuid) }
  end
  
end