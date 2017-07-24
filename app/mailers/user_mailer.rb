class UserMailer < ActionMailer::Base
  default :from => "from@example.com"

  def welcome_email(user)
    @user = user
    @url = "http://example.com/login"
    mail(:to => user.email, :subject => "Welcome to my site")
  end

  def send_articles_email(user, article)
    @user = user
    @article = article
    mail(:to => user.email,
         :subject => "Last 10 articles")
  end

  def send_articles_email2(user, article)
    @user = user
    @article = article
    mail(:to => user.email,
         :subject => "Last 10 articles from last 5 registered users")
  end
end
