class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  impressionist actions: [:show], unique: [:session_hash]

  def index
    if params[:category].blank?
    @groups = Group.all     # controller 找到数据库里的所有的group数据，把它赋值给变量@groups。@groups这个变量，提供给groups/index.html.erb使用。
  else
    @category_id = Category.find_by(name: params[:category]).id
    @groups = Group.where(category_id: @category_id)
  end
end

  def show
    @group = Group.find(params[:id])   # ID就是http://localhost:3000/groups/1里的1.在数据库表里找到ID是1的group信息，把它赋值给实体变量@group，显示出来
    @comments = @group.comments
  end

  def new
    @group = Group.new   #在数据库里新建一个讨论组，并把它赋值给@group
    @categories = Category.all.map { |c| [c.name, c.id]}
  end

  def create
    @group = Group.new(group_params)    #从数据库里找到新建的group，（group params 只允许应该修改的栏位修改），把它的值传给实体变量@group
    @group.category_id = params[:category_id]
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
    @categories = Category.all.map { |c| [c.name, c.id]}
  end

  def update
    @group = Group.find(params[:id])  # 在数据库表中根据group的ID找到相应的group，把值传给实体变量@group
    @group.category_id = params[:category_id]
    if @group.update(group_params)       # 实体变量@group对group params 进行更新
      redirect_to groups_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])   # 在数据库表中根据group的ID找到相应的group，把值传给实体变量@group
    @group.destroy                     # 实体变量@group里的数据，毁掉
    flash[:alert] = "Group deleted"
    redirect_to groups_path
  end

  def upvote
    @group = Group.find(params[:id])
    @group.votes.create
    redirect_to(group_path)
  end

  private

  def group_params
    params.require(:group).permit(:title, :description, :image, :category_id)
  end

end
