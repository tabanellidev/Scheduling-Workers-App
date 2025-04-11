class CleanersController < ApplicationController
  before_action :set_cleaner, only: %i[ show edit update destroy ]

  # GET /cleaners or /cleaners.json
  def index
    @cleaners = Cleaner.all
  end

  # GET /cleaners/1 or /cleaners/1.json
  def show

    @index = DateTime.now()

    @week = Job.where(cleaner_id: params[:id]).order(date: :desc)

    @repeatable_jobs = RepeatableJob.where(cleaner_id: params[:id])

  end

  # GET /cleaners/new
  def new
    @cleaner = Cleaner.new
  end

  # GET /cleaners/1/edit
  def edit
  end

  # POST /cleaners or /cleaners.json
  def create
    @cleaner = Cleaner.new(cleaner_params)

    respond_to do |format|
      if @cleaner.save
        format.html { redirect_to cleaner_url(@cleaner), notice: "Cleaner was successfully created." }
        format.json { render :show, status: :created, location: @cleaner }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cleaner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cleaners/1 or /cleaners/1.json
  def update
    respond_to do |format|
      if @cleaner.update(cleaner_params)
        format.html { redirect_to cleaner_url(@cleaner), notice: "Cleaner was successfully updated." }
        format.json { render :show, status: :ok, location: @cleaner }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cleaner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cleaners/1 or /cleaners/1.json
  def destroy
    @cleaner.destroy!

    respond_to do |format|
      format.html { redirect_to cleaners_url, notice: "Cleaner was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def summary

    if params[:index].nil?
      @index = DateTime.now()
    else
      @now = DateTime.now()
      @shift = params[:index]
      @index = @now + @shift.to_i * 7
    end

    start_date = @index.beginning_of_week(:monday)
    nextday = start_date

    @listweek = []
    @listweek.append(start_date)
    6.times do 

      nextday = nextday + 1
      @listweek.append(nextday)

    end

    end_date = @listweek.last
    id = params[:id]

    @cleaner = Cleaner.find(id)

    @jobs_week = Job.where(date: start_date..end_date, cleaner_id: id).order("date")

    list_eng = []

    @jobs_per_day = {}
    @jobs_per_day["Mon"] = []
    @jobs_per_day["Tue"] = []
    @jobs_per_day["Wed"] = []
    @jobs_per_day["Thu"] = []
    @jobs_per_day["Fri"] = []
    @jobs_per_day["Sat"] = []

    @total_hour = 0

    @jobs_week.each do |job|

      @jobs_per_day[job.date.strftime("%a")].append([job, job.job_collegues])
      puts(job, job.job_collegues)
      @total_hour = @total_hour + job.duration
      
    end

  end

  def week
   
    @listday = ['Lunedì', 'Martedì','Mercoledì','Giovedì','Venerdì','Sabato','Domenica']
    @listtimes = ['06:00','06:15','06:30','06:45',
                  '07:00','07:15','07:30','07:45',
                  '08:00','08:15','08:30','08:45',
                  '09:00','09:15','09:30','09:45',
                  '10:00','10:15','10:30','10:45',
                  '11:00','11:15','11:30','11:45',
                  '12:00','12:15','12:30','12:45',
                  '13:00','13:15','13:30','13:45',
                  '14:00','14:15','14:30','14:45',
                  '15:00','15:15','15:30','15:45',
                  '16:00','16:15','16:30','16:45',
                  '17:00','17:15','17:30','17:45',
                  '18:00','18:15','18:30','18:45',
                  '19:00'] 

    if params[:index].nil?
      @index = DateTime.now()
    else
      @now = DateTime.now()
      @shift = params[:index]
      @index = @now + @shift.to_i * 7
    end

    start_date = @index.beginning_of_week(:monday)
    nextday = start_date

    @listweek = []
    @listweek.append(start_date)
    6.times do 

      nextday = nextday + 1
      @listweek.append(nextday)

    end

    end_date = @listweek.last
    id = params[:id]

    @cleaner = Cleaner.find(id)

    @jobs_week = Job.where(date: start_date..end_date, cleaner_id: id)

    @jobsdict = {}

    @total_hour = 0
    @jobs_minutes = []
      
    @jobs_week.each do |job|

      if job.invalid_min?
        @jobs_minutes.append(job)
      end

      index = job.date.strftime('%d-%m-%Y %H:%M')
      
      if @jobsdict[index].nil?

        @jobsdict[index] = {}

        @hash_index = job.site_id.to_s + '$' + job.site.nome

        if @jobsdict[index][@hash_index].nil?

          @jobsdict[index][@hash_index] = []

          @collegues = Job.where(date: job.date, site_id: job.site_id).where.not(cleaner_id: job.cleaner_id)

          @other_cleaner = []

          @collegues.each do |col|

            @col_temp = [col.cleaner_id, col.cleaner.name, col.id, col.cleaner.internaln]

            @other_cleaner.push(@col_temp)

          end

          @temp = [job.id , job.cleaner.id, job.cleaner.name, job.duration, job.cleaner.internaln, @other_cleaner]

          @total_hour = @total_hour + job.duration

          @jobsdict[index][@hash_index].push(@temp)

        else

          @temp = [job.id , job.cleaner.id, job.cleaner.name, job.duration, job.cleaner.internaln]

          @total_hour = @total_hour + job.duration

          @jobsdict[index][@hash_index].push(@temp)

        end


      else

        @hash_index = job.site_id.to_s + '$' + job.site.nome

        if @jobsdict[index][@hash_index].nil?

          @jobsdict[index][@hash_index] = []

          @temp = [job.id , job.cleaner.id, job.cleaner.name, job.duration, job.cleaner.internaln]

          @jobsdict[index][@hash_index].push(@temp)

        else

          @temp = [job.id , job.cleaner.id, job.cleaner.name, job.duration, job.cleaner.internaln]
          
          @jobsdict[index][@hash_index].push(@temp)

        end

      end

    end




    @jobs_duration = []

    jobs_week_error = Job.where(date: start_date..end_date, cleaner_id: @cleaner.id).order('date').reverse_order

    for i in (0..jobs_week_error.length-1)

        for i2 in (i+1..jobs_week_error.length-1)

            if jobs_week_error[i].date < jobs_week_error[i2].date + jobs_week_error[i2].duration * 3600
                @jobs_duration.append([jobs_week_error[i2] , jobs_week_error[i]])
            end

        end

    end



  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cleaner
      @cleaner = Cleaner.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cleaner_params
      params.require(:cleaner).permit(:name, :surname, :internaln, :codfis, :birthdate, :residence, :hired, :license, :email, :phone, :hours_required)
    end
end
