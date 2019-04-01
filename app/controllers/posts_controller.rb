class PostsController < ApplicationController
	before_action :authenticate_user!

	def new
		@post = Post.new
		@group = Group.find(params[:group_id])
	end

	def create
		@group = Group.find(params[:group_id])
		@post = Post.new(post_params)
		@post.user = current_user
		@post.group = @group
		if @post.save
			redirect_to group_path(@group), notice: "post create success"
		else
			render :new
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to account_posts_path, notice: "刪除文章成功"
	end


	private 
	def post_params
		params.require(:post).permit(:content)
	end
end
