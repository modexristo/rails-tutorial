class CommentsController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

  # the params returned from the form in the articles/show.html.erb
  # will be sth like:
  # params[] = {
  #   :controller => ''
  #   :action => ''
  #   :id = '1'
  #   :article => {
  #     :title => "title"
  #     :text => "text"
  #     :comment = { :commenter => "comm_id", :body => "comment"}
  #
  #   }
  # }
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def comment_params
    # why 'comment' and not 'comments' ?
    params.require(:comment).permit(:commenter, :body)
  end

end
