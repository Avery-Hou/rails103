class GroupsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :join, :quit]
	before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]

	def index
		@groups = Group.all
	end

	def new
		@group = Group.new
	end

	def create
		@group = Group.new(group_params)
		@group.user = current_user
		if @group.save
			redirect_to groups_path
		else 
			render :new
		end
	end

	def edit
		
	end

	def update
		if @group.update(group_params)
			redirect_to groups_path, notice: "update success"
		else
			render :edit
		end	
	end


	def show
		@group = Group.find(params[:id])
		@posts = @group.posts.includes(:user).recent.paginate(page: params[:page], per_page: 7)
	end

	def destroy
		@group.destroy
		flash[:alert] = "delete success"
		redirect_to groups_path
	end


	def join()
		@group = Group.find(params[:id])
		if current_user.is_member_of?(@group)
			flash[:warning] = "已是討論群成員，無需再加入"
		else
			flash[:notice] = "加入討論群成功"
			current_user.join!(@group)
		end
		redirect_to group_path(@group)
	end

	def quit()
		@group = Group.find(params[:id])
		if current_user.is_member_of?(@group)
			flash[:alert] = "退出討論群成功"
			current_user.quit!(@group)
		else
			flash[:warning] = "不是成員，如何退出?"
		end
		redirect_to group_path(@group)
	end

	private
	def group_params
		params.require(:group).permit(:title, :description)
	end

	def find_group_and_check_permission
		@group = Group.find(params[:id])
		if current_user != @group.user
			redirect_to groups_path, alert: "You have no permission"
		end
	end
end
