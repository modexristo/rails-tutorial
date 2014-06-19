class ArticlesController < ApplicationController
  def new

  end

  # the params[] object is the one that references the parameters returned from the form,
  # which happens to be a hash that models the resource.
  # I suppose that the key is the name of the resource (:article in this instance) and the
  # value is a hash of its attributes (in this example it is {title: "", text: ""})
  def create
    render plain: params[:article].inspect
  end
end
