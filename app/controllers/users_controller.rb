class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def shopping_list
    @user = current_user
    shopping_list_data = @user.shopping_list

    @shopping_list = shopping_list_data[:shopping_list]
    @total_price = shopping_list_data[:total_price]
    @total_value = shopping_list_data[:total_value]
  end

  private

  def user_params
    params.require(user).permit(:name)
  end
end
