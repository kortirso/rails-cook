class MeasuresController < ApplicationController
    before_filter :authenticate_user!
    before_action :set_measure, only: [:show, :edit, :update, :destroy]
    before_filter :set_accessible

    def index
        @measures = Measure.all
    end

    def show
    end

    def new
        @measure = Measure.new
    end

    def edit
    end

    def create
        @measure = Measure.new(measure_params)
        if @measure.save
            redirect_to @measure
        else
            render :new
        end
    end

    def update
        if @measure.update(measure_params)
            redirect_to @measure
        else
            render :edit
        end
    end

    def destroy
        @measure.destroy
        redirect_to measures_url
    end

    private
    def set_measure
        @measure = Measure.find(params[:id])
    end

    def measure_params
        params.require(:measure).permit(:name)
    end
end
