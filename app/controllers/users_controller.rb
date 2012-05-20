class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  before_filter :not_signed_in_user, only: [:new, :create]

  def new
  	    @user = User.new
  end



  def edit
  end
  
  def destroy 
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_path
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
  	else
  		render 'edit'
  	end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

 def create
 	@user = User.new(params[:user])
 	if @user.save
 		sign_in @user
 		flash[:success] = "Welcome to the Sample App"
 		redirect_to @user 
 	else
 		render 'new'
 	end
 end

 private


  def not_signed_in_user
    if signed_in?
      store_location
      redirect_to root_path, notice: "You are already signed up and signed in"
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
