class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login, :match_user
  
    $states = [ "AK","AL","AR","AS","AZ","CA","CO","CT","DC","DE","FL","GA","GU","HI","IA","ID","IL",
                "IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ",
                "NM","NV","NY","OH","OK","OR","PA","PR","RI","SC","SD","TN","TX","UT","VA","VI","VT",
                "WA","WI","WV","WY" ]
  
    def current_user
      User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
  
    def require_login
      return redirect_to users_new_path if not session[:user_id]
    end

    def match_user
      return redirect_to groups_index_path if params[:user_id].to_i != session[:user_id]
    end
end
