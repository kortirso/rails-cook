class CountriesController < ApplicationController
    before_filter :authenticate_user!
    before_action :set_country, only: [:show, :edit, :update, :destroy]
    before_filter :set_accessible

    def index
        @countries = Country.all
    end

    def show
    end

    def new
        @country = Country.new
    end

    def edit
    end

    def create
        @country = Country.new(country_params)
        if @country.save
            redirect_to @country, notice: 'Country was successfully created.'
        else
            render :new
        end
    end

    def update
        if @country.update(country_params)
            fredirect_to @country, notice: 'Country was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        @country.destroy
        redirect_to countries_url, notice: 'Country was successfully destroyed.'
    end

    private
    def set_country
        @country = Country.find(params[:id])
    end

    def country_params
        params.require(:country).permit(:name, :caption)
    end
end
