class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @pins = Pin.all
  end

  def show
  end

 
  def new
    @pin = current_user.pins.build
  end


  def edit
  end

  def create
    @pin = current_user.pins.build(pin_params)


      if @pin.save
        redirect_to @pin, notice: 'Pin was successfully created.' 
      else
        render action: 'new' 
      end
  end

  # PATCH/PUT /pins/1
  # PATCH/PUT /pins/1.json
  def update
      if @pin.update(pin_params)
        redirect_to @pin, notice: 'Pin was successfully updated.' 
        head :no_content 
      else
        render action: 'edit' 
        render json: @pin.errors, status: :unprocessable_entity 
      end
  end

 
  def destroy
    @pin.destroy
      redirect_to pins_url 
      head :no_content 
  end

  private

    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Unauthorized to edit this pin" if @pin.nil?
    end


    def pin_params
      params.require(:pin).permit(:description, :string)
    end
end
