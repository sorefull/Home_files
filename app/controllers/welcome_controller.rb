class WelcomeController < ApplicationController
  def index
  end

  def about
    Post.all.each do |post|
      if post.about_welcome
        @post = post
        break
      end
    end
  end

end
