class ArticlePolicy < ApplicationPolicy
  attr_reader :user, :article

  def initialize(user, article)
    @user = user
    @article = article
  end

  def destroy?
    if user.id == @article.user_id
      return true
    else
      return false
    end
  end

  def edit?
    if user.id == @article.user_id
      return true
    else
      return false
    end
  end
end
