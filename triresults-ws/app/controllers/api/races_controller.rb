module Api
  class RacesController < ApplicationController

    protect_from_forgery with: :null_session

    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
      else
        #real implementation ...
      end
    end

    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:id]}"
      else
        race = Race.find(params[:id])
        render json: race
      end
    end

    def create
      if !request.accept || request.accept == "*/*"
        race_name = params[:race][:name]
        render plain: race_name, status: :ok
      else
        race = Race.create(race_params)
        render plain: race.name, status: :created
      end
    end

    def update
      race = Race.find(params[:id])
      if race
        race.update_attributes(race_params)
        render json: race
      else
        render status: :not_found
      end
    end

    def destroy
      Race.find(params[:id]).destroy
      render nothing: true, status: :no_content
    end

    private

    def race_params
      params.require(:race).permit(:name, :date)
    end

  end
end