module Api
  class RacesController < ApplicationController

    protect_from_forgery with: :null_session

    rescue_from Mongoid::Errors::DocumentNotFound do |exception|
      @msg = "woops: cannot find race[#{params[:id]}]"
      if !request.accept || request.accept == "*/*"
        render plain: @msg, status: :not_found
      else
        render action: 'error', status: :not_found
      end
    end

    rescue_from ActionView::MissingTemplate do |exception|
      render plain: "woops: we do not support that content-type[#{request.accept}])", status: :unsupported_media_type
    end

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
        @race = Race.find(params[:id])
        render action: 'race'
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