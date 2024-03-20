class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to polymorphic_path(@comment.commentable)
    else
      redirect_to polymorphic_path(@comment.commentable), alert: @comment.errors.full_messages.join(", ")
    end
  end

  def comment_params
    params.require(:comment)
          .permit(:content, :author_name, :commentable_id, :commentable_type)
  end
end
