class Api::UsersController < Api::BaseController
  
  def index
  	  @data = {
  	  	ok: '123'
  	  }
  	  @users = User.all
  end	  

  def show
    @user = User.find(params[:id])
    
  end

  def create
  		render json: {created: true }
  end
  

  

end