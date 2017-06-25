class CommentsController < ApplicationController


    def create
      @group = Group.find(params[:group_id])
      @comment = @group.comments.new(comment_params)

      if @comment.save
        redirect_to group_path(@group), notice: "已评论"
      else
        redirect_to group_path(@group), notice: "内容不能为空"
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:content)
    end

end
