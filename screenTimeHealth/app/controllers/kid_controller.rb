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

  def add

  end

  def create
    @family = current_family
    if Kid.create(:name => params[:name], :family_id => @family.id)
      flash[:notice] = "Family member successfully added."
      redirect_to :controller => 'family', :action => 'view'
    else
      flash[:alert] = "Unsuccessful. Please try again."
      redirect_to :controller => 'family', :action => 'add'
    end
  end

  def delete
    @kid = Kid.find(params[:id])
    if @kid.destroy
      flash[:notice] = "Family member successfully deleted."
      redirect_to :controller => 'family', :action => 'view'
    end
  end

end
