class SessionsController < ApplicationController
    skip_before_action :require_login, :match_user
    
    def create
        @user = User.find_by_email(params[:email])
        if @user and @user.authenticate(params[:password])
            session[:user_id] = @user.id
            return redirect_to groups_index_path
        else 
            flash[:errors] = ["Invalid user name or password."]
            return redirect_to users_new_path
        end
    end

    def destroy
        reset_session
        return redirect_to users_new_path
    end
end
