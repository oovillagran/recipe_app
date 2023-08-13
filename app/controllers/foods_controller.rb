class FoodsController < ApplicationController
  def index
    @foods = Food.where(user_id: current_user.id)
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id
    if @food.save
      flash[:success] = 'Food was successfully created'
      redirect_to foods_path
    else
      flash[:alert] = 'Food was not created'
      render 'new'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    flash[:danger] = 'Food was successfully deleted'
    redirect_to foods_path
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
