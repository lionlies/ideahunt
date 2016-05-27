class IdeasController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :upvote, :downvote]

  def index
    @ideas = Idea.all
  end

  def show
    @idea = Idea.find(params[:id])
    @comments = @idea.comments
    @comment = @idea.comments.new
  end

  def new
    @idea = Idea.new
    @idea.owner = current_user
  end

  def create
    @idea = current_user.ideas.new(idea_params)
    @idea.owner = current_user

    if @idea.save
      redirect_to ideas_path
    else
      render :new
    end
  end

  def edit
    @idea = current_user.ideas.find(params[:id])
  end

  def update
    @idea = current_user.ideas.find(params[:id])

    if @idea.update(idea_params)
      redirect_to ideas_path
    else
      render :edit
    end
  end

  def destroy
    @idea = current_user.ideas.find(params[:id])
    @idea.destroy
    redirect_to ideas_path
  end

  def upvote
    @idea= Idea.find(params[:id])
    if @idea.votes.create(user_id: current_user.id)
      flash[:notice] = "Thank you for upvoting!"

      # @vote = @idea.votes.create
      redirect_to :back
    else
      flash[:notice] =  "You have already upvoted this!"
      redirect_to :back
    end
  end

  def downvote
    @idea = Idea.find(params[:id])
    @idea.votes.last.delete
    redirect_to :back
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description)
  end

end
