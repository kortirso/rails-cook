class LineIngridsController < ApplicationController
  before_action :set_line_ingrid, only: [:show, :edit, :update, :destroy]

  # GET /line_ingrids
  # GET /line_ingrids.json
  def index
    @line_ingrids = LineIngrid.all
  end

  # GET /line_ingrids/1
  # GET /line_ingrids/1.json
  def show
  end

  # GET /line_ingrids/new
  def new
    @line_ingrid = LineIngrid.new
  end

  # GET /line_ingrids/1/edit
  def edit
  end

  # POST /line_ingrids
  # POST /line_ingrids.json
  def create
    @line_ingrid = LineIngrid.new(line_ingrid_params)

    respond_to do |format|
      if @line_ingrid.save
        format.html { redirect_to @line_ingrid, notice: 'Позиция для ингридиента добавлена' }
        format.json { render :show, status: :created, location: @line_ingrid }
      else
        format.html { render :new }
        format.json { render json: @line_ingrid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_ingrids/1
  # PATCH/PUT /line_ingrids/1.json
  def update
    respond_to do |format|
      if @line_ingrid.update(line_ingrid_params)
        format.html { redirect_to @line_ingrid, notice: 'Line ingrid was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_ingrid }
      else
        format.html { render :edit }
        format.json { render json: @line_ingrid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_ingrids/1
  # DELETE /line_ingrids/1.json
  def destroy
    @line_ingrid.destroy
    respond_to do |format|
      format.html { redirect_to line_ingrids_url, notice: 'Line ingrid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_ingrid
      @line_ingrid = LineIngrid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_ingrid_params
      params.require(:line_ingrid).permit(:ingridient_id, :recipe_id)
    end
end
