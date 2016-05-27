class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_idea

  def new
    @comment = @idea.comments.new
  end

  def create
    @comment = @idea.comments.new(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to idea_path(@idea)
    else
      render :new
    end
  end

  def index
    @comments = @idea.comments
  end

  def show
    @comment = @idea.comments.find(params[:id])
  end

  def edit
    @comment = @idea.comments.find(params[:id])
  end

  def update
    @comment = @idea.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to idea_path(@idea)
    else
      render :edit
    end
  end

  def destroy
    @comment = @idea.comments.find(params[:id])
    @comment.destroy
    redirect_to @idea
  end

  private

  def find_idea
    @idea = Idea.find(params[:idea_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
