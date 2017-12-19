class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]
    skip_before_action :match_user, only: [:new, :create]
    
    layout :resolve_layout
    
    def new
        render 'loginreg.html.erb'
    end
  
    def create
      @user = User.create(user_params)
      if @user.invalid?
        flash[:errors] = @user.errors.full_messages
        return redirect_to users_new_path
      end
      flash[:messages] = ["User successfully created. Please log in."]
      return redirect_to users_new_path
    end
  
    def show
      
    end
  
    def edit
      @user = User.find(session[:user_id])
    end
  
    def update
      @user = User.update(session[:user_id], user_params)
      if not @user  
        flash[:errors] = ["Validations failed. Did not update."]
        return redirect_to users_edit_path session[:user_id]
      end
      return redirect_to users_show_path
    end
  
    private
      def user_params
          params.require(:user).permit(:first_name, :last_name, :city, :state, :email, :password, :password_confirmation)
      end

      def resolve_layout
        case action_name
          when "show", "edit"
            "exam"
          else
            "application"
          end
      end
end
