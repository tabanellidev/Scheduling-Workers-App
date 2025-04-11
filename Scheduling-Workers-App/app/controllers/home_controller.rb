class HomeController < ApplicationController

    def index
        now = DateTime.now()
        start_date = now.beginning_of_week(:monday)
        end_date = start_date + 6  

        cleaners = Cleaner.all()

        @warning_list = []

        cleaners.each do |cleaner|

            @jobs_week = Job.where(date: start_date..end_date, cleaner_id: cleaner.id).order('date').reverse_order

            for i in (0..@jobs_week.length-1)

                for i2 in (i+1..@jobs_week.length-1)

                    if @jobs_week[i].date < @jobs_week[i2].date + @jobs_week[i2].duration * 3600
                        @warning_list.append([@jobs_week[i] , @jobs_week[i2]])
                    end

                end

            end

        end


        @jobs_week = Job.where(date: start_date..end_date).order('date').reverse_order


    end

end
