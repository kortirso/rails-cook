class IngridientsController < ApplicationController
  before_action :set_ingridient, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :set_accessible, except: [:new, :create]

  def index
    @ingridients = Ingridient.all
  end

  def show
  end

  def new
    @ingridient = Ingridient.new
  end

  def edit
  end

  def create
    @ingridient = Ingridient.new(ingridient_params)

    respond_to do |format|
      if @ingridient.save
        format.html { redirect_to @ingridient, notice: 'Ingridient was successfully created.' }
        format.json { render :show, status: :created, location: @ingridient }
      else
        format.html { render :new }
        format.json { render json: @ingridient.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ingridient.update(ingridient_params)
        format.html { redirect_to @ingridient, notice: 'Ingridient was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingridient }
      else
        format.html { render :edit }
        format.json { render json: @ingridient.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ingridient.destroy
    respond_to do |format|
      format.html { redirect_to ingridients_url, notice: 'Ingridient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_ingridient
      @ingridient = Ingridient.find(params[:id])
    end

    def ingridient_params
      params.require(:ingridient).permit(:caption, :name_path, :name)
    end
end
