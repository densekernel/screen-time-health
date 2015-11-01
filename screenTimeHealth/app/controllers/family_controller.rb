class FamilyController < ApplicationController

  def view
    @family = current_family
    @kids = current_family.kids

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
  end

  def edit
    @family = current_family
    @family_name = @family.surname
  end

  def add

  end

  def family_params
    params.require(:family).permit(:id, :email, :surname, kids_attributes: [:id, :name, :_destroy])
  end


end


