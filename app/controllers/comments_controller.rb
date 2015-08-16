class CommentsController < ApplicationController
  # before_action :signed_in_user, only: [:create]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      @comment.user = User.find(@comment.user_id)
      render :json => { status: "success", comment: { comment: @comment.comment, created_at_jst: @comment.created_at_jst.strftime('%Y年%m月%d日 %H:%M:%S'), user: { full_name: @comment.user.full_name } } }
    else
      render :json => { status: "failure", comment: {}, message: @comment.errors.full_messages }
    end
  end

  private

    def comment_params
      comment_params = params.permit(:comment, :diary_id)
    end
end
