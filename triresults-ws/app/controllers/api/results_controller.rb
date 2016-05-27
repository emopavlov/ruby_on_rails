module Api
  class ResultsController < ApplicationController
    
    protect_from_forgery with: :null_session

    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:race_id]}/results"
      else
        race = Race.find(params[:race_id])
        last_updated = race.entrants.max(:updated_at)
        
        if stale?(etag: @results, last_modified: last_updated)
          @results = race.entrants
        end
      end
    end

    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
      else
        result = Race.find(params[:race_id]).entrants.where(id: params[:id]).first
        render partial: 'result', object: result
      end
    end

    def update
      entrant = Race.find(params[:race_id]).entrants.where(id: params[:id]).first
      result = params[:result]
      if result
        [:swim, :t1, :bike, :t2, :run].each do |prop_name|
          set_property(entrant, prop_name, result[prop_name])
        end

        entrant.save
      end

      render nothing: true
    end

    def set_property(entrant, name, value) 
      if name && value
        entrant.send("#{name}=", entrant.race.race.send("#{name}"))
        entrant.send("#{name}_secs=", value.to_f)
      end
    end
  end
end