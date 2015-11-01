class KidController < ApplicationController
  def view
    @kid = Kid.find(params[:id])
    
    if(@kid.session.count != 0)
      @session_data = {}

    current_date = @kid.session.first.starttime.strftime("%d-%m-%Y")
    key = current_date 
    # key = @kid.session.first.starttime.strftime("%A") + " " + @kid.session.first.starttime.strftime("%A")
    session_arr = []
    prevendtime  = @kid.session.first.endtime
    period_data = []
    period_keys = []
    total = 0

    @sessions = @kid.session.order(:starttime)

    @sessions.each_with_index do |session, index|

      starttime = session.starttime
      endtime = session.endtime
      if session.endtime.nil?
        endtime = Time.now
      end
   
      if index == 0

        period_keys.push(starttime.strftime("%d-%m-%Y"))
      
        total += (endtime - starttime) / 60
        prevendtime = session.endtime.nil? ? Time.now : session.endtime

      else

        # save period
        puts 'diff'
        puts starttime
        puts prevendtime
        puts starttime - prevendtime

        if ((starttime - prevendtime) > (5 * 60))
          puts 'new stamp'
          period_data.push(total)
          
          period_keys.push(starttime.strftime("%d-%m-%Y"))
          total = (endtime - starttime) / 60
        else
          puts 'total'
          total += (endtime - starttime) / 60
        end 

        prevendtime = session.endtime

      end

      if(session.starttime.strftime("%d-%m-%Y") != current_date)
        @session_data[key] = session_arr
        puts 'after pushed to map'
        puts @session_data[key]

        current_date = session.starttime.strftime("%d-%m-%Y")
        # key = current_date + " " + session.starttime.strftime("%A")
        key = current_date 
        session_arr = []
      else
        starttime = session.starttime
        endtime = session.endtime.nil? ? Time.now : session.endtime
        session_duration_mins = (endtime - starttime) / 60
        session_arr.push(session_duration_mins)
        puts 'hereeee'
        puts session_arr
      end
    end

    @avg_hours = ((period_data.inject { |sum, e| sum + e }.to_f / period_data.size) / 60).round(2)


    @sessionchart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Session Data for " + @kid.name)
      f.xAxis(:categories => period_keys)
      f.series(:name => "hours", :yAxis => 0, :data => period_data.collect{|d| (d / 60).round(2) })

      f.yAxis [
        {:title => {:text => "Sesstion Time in Minutes", :margin => 70} },
      ]

      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"column"})
    end

    
    

require 'json'
  file = File.read('app/assets/jsons/obese_percentages.json')
  @data_hash = JSON.parse(file)

  @chart = []
  for each_data_hash in @data_hash
    data_hash_name = each_data_hash[0]
    data_hash_data = each_data_hash[1]
    newchart = LazyHighCharts::HighChart.new('pie') do |f|
        f.chart({:defaultSeriesType=>"pie" , :margin=> [0, 0, 0, 0]} )
        series = {
               :type=> 'pie',
               :name=> '%people',
               :data=> [
                  [data_hash_data.keys[0],   data_hash_data.values[0]],
                  [data_hash_data.keys[1],   data_hash_data.values[1]],
                  [data_hash_data.keys[2],   data_hash_data.values[2]]
               ]
        }
        f.series(series)
        f.options[:title][:text] = data_hash_name
        f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '5px',:top=> '10px'}) 
        f.plot_options(:pie=>{
          :allowPointSelect=>true, 
          :cursor=>"pointer" , 
          :dataLabels=>{
              :enabled=>true,
              :color=>"black",
              :style=>{
                :font=>"13px Trebuchet MS, Verdana, sans-serif"
                }
            }
          })
      end
      @chart.append(newchart)
    end


    puts @session_data
    gon.session = @session_data
    gon.avg = @avg_hours

       end
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
