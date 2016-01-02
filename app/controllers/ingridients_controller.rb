class IngridientsController < ApplicationController
    before_filter :authenticate_user!
    before_action :set_ingridient, only: [:show, :edit, :update, :destroy]
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
        if @ingridient.save
            redirect_to @ingridient, notice: 'Ingridient was successfully created.'
        else
            render :new
        end
    end

    def update
        if @ingridient.update(ingridient_params)
            redirect_to @ingridient, notice: 'Ingridient was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        @ingridient.destroy
        redirect_to ingridients_url, notice: 'Ingridient was successfully destroyed.'
    end

    private
    def set_ingridient
        @ingridient = Ingridient.find(params[:id])
    end

    def ingridient_params
        params.require(:ingridient).permit(:caption, :name_path, :name)
    end
end
