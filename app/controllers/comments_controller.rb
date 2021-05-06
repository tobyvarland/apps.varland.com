class CommentsController < ApplicationController

  before_action :set_comment, only: %i[ edit update destroy ]

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to @comment.commentable
    else
      flash[:alert] = "Failed to add comment. Please try again or contact IT for help."
      redirect_back fallback_location: root_path
    end
  end

  def update
    if @comment.update(comment)
      redirect_to @comment.commentable
    else
      redirect_to @comment.commentable, alert: "Error updating comment. Please try again or contact IT for help."
    end
  end

  def destroy
    @comment.discard
    redirect_to @comment.commentable
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:user_id,
                                      :commentable_id,
                                      :commentable_type,
                                      :body,
                                      :comment_at,
                                      attachments_attributes: [:id, :name, :description, :file, :_destroy])
    end

end