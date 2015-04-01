class IngridientsController < ApplicationController
  before_action :set_ingridient, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :set_accessible, except: [:new, :create]

  # GET /ingridients
  # GET /ingridients.json
  def index
    @ingridients = Ingridient.all
  end

  # GET /ingridients/1
  # GET /ingridients/1.json
  def show
  end

  # GET /ingridients/new
  def new
    @ingridient = Ingridient.new
  end

  # GET /ingridients/1/edit
  def edit
  end

  # POST /ingridients
  # POST /ingridients.json
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

  # PATCH/PUT /ingridients/1
  # PATCH/PUT /ingridients/1.json
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

  # DELETE /ingridients/1
  # DELETE /ingridients/1.json
  def destroy
    @ingridient.destroy
    respond_to do |format|
      format.html { redirect_to ingridients_url, notice: 'Ingridient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingridient
      @ingridient = Ingridient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingridient_params
      params.require(:ingridient).permit(:caption, :name_path, :name)
    end
end
