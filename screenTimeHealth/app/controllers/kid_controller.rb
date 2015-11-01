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

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Population vs GDP For 5 Big Countries [2009]")
      f.xAxis(:categories => ["United States", "Japan", "China", "Germany", "France"])
      f.series(:name => "GDP in Billions", :yAxis => 0, :data => [14119, 5068, 4985, 3339, 2656])
      f.series(:name => "Population in Millions", :yAxis => 1, :data => [310, 127, 1340, 81, 65])

      f.yAxis [
        {:title => {:text => "GDP in Billions", :margin => 70} },
        {:title => {:text => "Population in Millions"}, :opposite => true},
      ]

      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"column"})
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
