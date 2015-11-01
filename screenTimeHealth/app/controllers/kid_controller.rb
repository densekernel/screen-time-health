class KidController < ApplicationController
  def view
    @kid = Kid.find(params[:id])
    
    @session_data = {}

    current_date = @kid.session.first.startTime.strftime("%d%m%Y")
    key = current_date + " " + @kid.session.first.startTime.strftime("%A")
    session_arr = []

    @kid.session.each do |session|
   

      if(session.startTime.strftime("%d%m%Y") != current_date)
        @session_data[key] = session_arr

        current_date = session.startTime.strftime("%d%m%Y")
        key = current_date + " " + session.startTime.strftime("%A")
      else
        startTime = session.startTime
        endTime = session.endTime
        session_duration_mins = (endTime - startTime) / 60
        session_arr.push(session_duration_mins)
      end
    end

    puts @session_data
    gon.session = @session_data

  end
end
