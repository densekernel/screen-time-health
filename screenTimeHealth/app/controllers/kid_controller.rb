class KidController < ApplicationController
  def view
    @kid = Kid.find(params[:id])
    
    if(@kid.session.length != 0)
      @session_data = {}

    current_date = @kid.session.first.startTime.strftime("%d-%m-%Y")
    key = current_date 
    # key = @kid.session.first.startTime.strftime("%A") + " " + @kid.session.first.startTime.strftime("%A")
    session_arr = []



    @kid.session.each do |session|
   
      if(session.startTime.strftime("%d-%m-%Y") != current_date)
        @session_data[key] = session_arr

        current_date = session.startTime.strftime("%d-%m-%Y")
        # key = current_date + " " + session.startTime.strftime("%A")
        key = current_date 
      else
        startTime = session.startTime
        endTime = session.endTime
        session_duration_mins = (endTime - startTime) / 60
        session_arr.push(session_duration_mins)
      end
    end

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Session Data for " + @kid.name)
      f.xAxis(:categories => @session_data.keys)
      f.series(:name => "minutes", :yAxis => 0, :data => @session_data.values)

      f.yAxis [
        {:title => {:text => "Sesstion Time in Minutes", :margin => 70} },
      ]

      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"column"})
    end
    end
    

    puts @session_data
    gon.session = @session_data

  end

  def add

  end

  def create
    @family = current_family
    if Kid.create(:name => params[:name], :threshold => params[:threshold], :family_id => @family.id)
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
