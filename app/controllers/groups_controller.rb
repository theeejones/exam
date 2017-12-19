class GroupsController < ApplicationController

    skip_before_action :require_login, only: [:new, :create]
    skip_before_action :match_user

    layout :resolve_layout

    def index
        @groups = Group.find_by_sql("SELECT groups.*, count(usergroups.user_id) AS usercount FROM groups LEFT OUTER JOIN usergroups ON groups.id = usergroups.group_id GROUP BY groups.id ORDER BY usercount DESC;")
    end

    def create
        @group = Group.create(name: params[:name], desc: params[:desc], creator: session[:user_id])
        if @group.invalid?
            flash[:errors] = @user.errors.full_messages
        else
            Usergroup.create(user_id: session[:user_id], group_id: @group.id)
        end
        return redirect_to groups_index_path
    end

    def destroy
        Group.destroy(params[:group_id])
        return redirect_to groups_index_path
    end

    def join
        @usergroup = Usergroup.find_by(user_id: session[:user_id], group_id: params[:group_id])
        Usergroup.create(user_id: session[:user_id], group_id: params[:group_id]) if not @usergroup
        return redirect_to groups_index_path
    end

    def leave 
        @usergroup = Usergroup.find_by(user_id: session[:user_id], group_id: params[:group_id])
        Usergroup.destroy(@usergroup.id) if @usergroup
        return redirect_to groups_index_path
    end

    def show
        @group = Group.find(params[:group_id])
        @creator = User.find(@group.creator)
        @usergroups = []
        current_user.groups.each do |group|
            @usergroups.push(group.id)
        end
    end

    private
    def resolve_layout
      case action_name
        when "index", "show"
          "exam"
        else
          "application"
        end
    end
end
