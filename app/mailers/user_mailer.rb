class UserMailer < ApplicationMailer
  default from: "Your Name <your.name@example.com>",
          return_path: 'your.name@example.com',
          sender: 'your.name@example.com'

  def today_news(user)
    @posts = Post.where("created_at >= ?", Time.zone.now.beginning_of_day)
    if @posts.count > 0
      @user = user
      mail(to: @user.email, subject: 'News set for today')
    else
      false
    end
  end

end
