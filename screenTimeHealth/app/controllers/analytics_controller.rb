class AnalyticsController < ApplicationController
  def start
    @kid = Kid.find_by(:unique_token => params[:unique_token].to_s)
    Session.create(:startTime => Time.now, :kid_id => @kid.id)
  end

  def end
    @kid = Kid.find_by(:unique_token => params[:unique_token].to_s)
    @session = @kid.session.last.update(:endTime => Time.now)
  end
end
