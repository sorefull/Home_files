desc "Send daily email to users with posts"

task :email_sender => :environment do |_, args|
  User.find_each do |user|
    UserMailer.today_news(user).deliver!
  end
end
