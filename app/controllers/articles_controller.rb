class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
    # when this action is called from a failed attempt to create a new article, the instance
    # @article is initialized to an empty one. How does it contain the errors of the failed
    # ArticlesController#create?
    @article = Article.new
  end

  # the params[] object is the one that references the parameters returned from the form,
  # which happens to be a hash that models the resource.
  # The format of the returned params is:
  # article: {title: 'article title here',text: 'article text here'}}
  #
  # I suppose that the key is the name of the resource (:article in this instance) and the
  # value is a hash of its attributes (in this example it is {title: "", text: ""})

  def create
    # this is used when first creating the ArticlesController#create, to display the info that
    # it receives from the articles/new.html.erb view through the Rails params object
    #render plain: params[:article].inspect

    # if we use this, while saving a new article Rails will complain about a forbidden attribute.
    #@article = Article.new(params[:article])
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      # call ArticlesController#new method
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def show
    # fetch the selected article from the model into the instance @article, which will
    # be passed from Rails to the the view.
    @article = Article.find(params[:id])
  end

  # the returned params will be sth like:
  # params[] = {
  #   :controller => 'articles'
  #   :action => 'edit'
  #   :id => 'x'
  #   :article => {
  #     :title => "new title"
  #   }
  # }
  # if more article attributes are edited, they will be included as well
  # ref. : https://stackoverflow.com/questions/8058835/passing-parameters-to-update-nested-attributes
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    # Suppose that params == { person: {title: 'Me', last: 'McMe'},
    #                          job: {title: 'programmer'} }
    # then params.require(:person) => {title: 'Me', last: 'McMe'} and
    # params.require(:job) => {title: 'programmer'}
    #
    # Also, params.require(:person).permit(:title) = > {title: 'Me'}
    params.require(:article).permit(:title, :text)
  end
end
