# Class ArticlesController
class V2::ArticlesController < ApplicationController
#  http_basic_authenticate_with name: 'dhh',
#                               password: 'secret',
#                               except: %i[index show]

  def index
    #@articles = Article.order(:created_at).page params[:page]
    @articles = Article.all.page(params[:page]).per(10)
    render json: @articles
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
    authorize @article
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    #authorize @article
    if @article.update(article_params)
      render json: @article
    else
      render json: "Error"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    authorize @article
    @article.destroy

    redirect_to articles_path, notice: 'Article was successfully destroyed.'
  end

  #def test
  #  @articles = Article.all
  #  render json: @articles
  #end

  private

  def article_params
    #params.require(:article).permit(:title, :text)
    params.permit(:title, :text)
  end
end
