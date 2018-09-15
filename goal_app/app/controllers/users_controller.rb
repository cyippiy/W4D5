class UsersController < ApplicationController
  
  def index
    @user = User.all
    render :index
  end
  
  def show
    @user = User.find(params[:id])
    # User.find_by_username('')
    # User.find_by(username: '')
    render :show
  end
  
  def create
    @user = User.new(user_params)
    redirect_to users_url(@user)
  end
  
  
  def new
    render :new    
  end
  
  def edit
    
    render :edit
  end
  
  def update
    
  end
  
  def user_params
    params.require(:users).permit(:username, :password)
  end
  
end
