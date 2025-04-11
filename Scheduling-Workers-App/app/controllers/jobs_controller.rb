class JobsController < ApplicationController
  before_action :set_job, only: %i[ show edit update destroy ]

  # GET /jobs or /jobs.json
  def index
    @jobs = Job.all.order(date: :desc)
  end

  # GET /jobs/1 or /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
    @cleaners = Cleaner.all
    @sites = Site.all

    if not params[:cleaner].nil?
      @temp_id = Cleaner.id_to_internaln(params[:cleaner])
    end

    # Collegues should be addable in new
    @collegues = true

  end


  # GET /jobs/1/edit
  def edit

    @cleaners = Cleaner.all
    @sites = Site.all

    # Collegues should NOT be addable in new
    @collegues = false


  end

  # POST /jobs or /jobs.json
  def create
    @job = Job.new(job_params)
    clid = Cleaner.internaln_to_id(job_params[:cleaner_id])
    @job.cleaner_id = clid
    @collegues = true

    if not params[:collegues].nil?
      puts("Colleghe trovate")
      errors = false
      #Add first job to array
      jobs = []
      temp_job_params = job_params
      temp_job_params['cleaner_id'] = Cleaner.internaln_to_id(job_params[:cleaner_id]).to_s
      jobs.append(temp_job_params)

      #Add all other collegues to jobs
      params[:collegues].each do |key,col|
        
        temp_job_params = job_params
        temp_job_params['cleaner_id'] = Cleaner.internaln_to_id(col).to_s
        jobs.append(temp_job_params)

      end

      @job = Job.create_all(jobs)
      puts(@job)

      respond_to do |format|
        if @job != 1
          if  @job.errors.full_messages.include? "Cleaner can't be blank"
            puts(@job.errors.delete(:cleaner_id))
            puts(@job.errors.add(:cleaner_id, "Collega Errore"))
          end
          puts(@job.errors.full_messages)
          
          #puts(@job.errors.full_messages_for(:duration))
          #puts(@job.errors.full_messages_for(:collegues))

          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @job.errors, status: :unprocessable_entity }
          
          @cleaners = Cleaner.all
          @sites = Site.all

        else
          puts("Tutto bene")
          format.html { redirect_to jobs_week_url, notice: "Job was successfully created." }
          format.json { render json: res, status: :unprocessable_entity }
        end
      end

    else

      puts("Nessuna collega trovata " + clid.to_s)
      respond_to do |format|
        if @job.save 
          format.html { redirect_to jobs_week_url, notice: "Job was successfully created." }
          format.json { render :show, status: :created, location: @job }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @job.errors, status: :unprocessable_entity }
          #To reload lists in jobs/new
          @cleaners = Cleaner.all
          @sites = Site.all
        end
      end
    end

  end

  # PATCH/PUT /jobs/1 or /jobs/1.json
  def update

    temp_job_params = job_params
    temp_job_params[:cleaner_id] = Cleaner.internaln_to_id(job_params[:cleaner_id])

    respond_to do |format|
      if @job.update(temp_job_params)
        format.html { redirect_to job_url(@job), notice: "Job was successfully updated." }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }

        #To reload lists in jobs/new
        @cleaners = Cleaner.all
        @sites = Site.all
      end
    end
  end

  # DELETE /jobs/1 or /jobs/1.json
  def destroy
    @job.destroy!

    respond_to do |format|
      format.html { redirect_to jobs_url, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def week

    puts(params)

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

    @jobs_week = Job.where(date: start_date..end_date)

    @jobsdict = {}

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

          @temp = [job.id , job.cleaner.id, job.cleaner.name, job.duration, job.cleaner.internaln]

          @jobsdict[index][@hash_index].push(@temp)

        else

          @temp = [job.id , job.cleaner.id, job.cleaner.name, job.duration, job.cleaner.internaln]

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

    cleaners = Cleaner.all()
    cleaners.each do |cleaner|

      jobs_week_error = Job.where(date: start_date..end_date, cleaner_id: cleaner.id).order('date').reverse_order

      for i in (0..jobs_week_error.length-1)
  
          for i2 in (i+1..jobs_week_error.length-1)
  
              if jobs_week_error[i].date < jobs_week_error[i2].date + jobs_week_error[i2].duration * 3600
                  @jobs_duration.append([jobs_week_error[i2] , jobs_week_error[i]])
              end
  
          end
  
      end
  

    end



  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:date, :duration, :index, :notes, :cleaner_id, :site_id, :collegues)
    end
end
