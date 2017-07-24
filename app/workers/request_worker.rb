class RequestWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
    @user = User.last(5)
    userid = @user.map { |u| u.id }
    
    @article = Article.where(:user_id => userid)
    @article.each do |a|
      puts a.title
    end

    UserMailer.send_articles_email2(@user, @article).deliver
  end
end
