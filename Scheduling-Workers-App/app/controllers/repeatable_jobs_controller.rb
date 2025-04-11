class RepeatableJobsController < ApplicationController
  before_action :set_repeatable_job, only: %i[ show edit update destroy ]

  # GET /repeatable_jobs or /repeatable_jobs.json
  def index
    @repeatable_jobs = RepeatableJob.all
  end

  # GET /repeatable_jobs/1 or /repeatable_jobs/1.json
  def show
  end

  # GET /repeatable_jobs/new
  def new
    @repeatable_job = RepeatableJob.new

    @cleaners = Cleaner.all
    @sites = Site.all

    if params[:index].nil?
      @index = DateTime.now()
    else
      @now = DateTime.now()
      @shift = params[:index]
      @index = @now + @shift.to_i.month
    end

    if not params[:cleaner].nil?
      @temp_id = Cleaner.id_to_internaln(params[:cleaner])
    end  

  end

  # GET /repeatable_jobs/1/edit
  def edit

    @cleaners = Cleaner.all
    @sites = Site.all

    @repeatable_job = RepeatableJob.find(params[:id])
    @repeatable_job.cleaner_id = Cleaner.id_to_internaln(@repeatable_job.cleaner_id)

  end

  # POST /repeatable_jobs or /repeatable_jobs.json
  def create
    @repeatable_job = RepeatableJob.new(repeatable_job_params)

    @repeatable_job.cleaner_id = Cleaner.internaln_to_id(repeatable_job_params[:cleaner_id])

    respond_to do |format|
      if @repeatable_job.save
        format.html { redirect_to repeatable_job_url(@repeatable_job), notice: "Repeatable job was successfully created." }
        format.json { render :show, status: :created, location: @repeatable_job }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @repeatable_job.errors, status: :unprocessable_entity }
        
        #To reload lists in jobs/new
        @cleaners = Cleaner.all
        @sites = Site.all
      end

    end

  end

  # PATCH/PUT /repeatable_jobs/1 or /repeatable_jobs/1.json
  def update

    temp_job_params = repeatable_job_params
    temp_job_params[:cleaner_id] = Cleaner.internaln_to_id(repeatable_job_params[:cleaner_id])


    respond_to do |format|
      if @repeatable_job.update(temp_job_params)
        format.html { redirect_to repeatable_job_url(@repeatable_job), notice: "Repeatable job was successfully updated." }
        format.json { render :show, status: :ok, location: @repeatable_job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @repeatable_job.errors, status: :unprocessable_entity }
      
        #To reload lists in jobs/new
        @cleaners = Cleaner.all
        @sites = Site.all
      end
      
      
    end
  end

  # DELETE /repeatable_jobs/1 or /repeatable_jobs/1.json
  def destroy
    @repeatable_job.destroy!

    respond_to do |format|
      format.html { redirect_to repeatable_jobs_url, notice: "Repeatable job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def copy

    rpj = RepeatableJob.find(params[:id])
    
    result, target_string = RepeatableJob.already_exist?(rpj)

    if result

      notice = 1
    
      redirect_to repeatable_job_url(rpj, notice: notice)

    else

      @job = Job.create(date: target_string, site_id: rpj.site_id, cleaner_id: rpj.cleaner_id, duration: rpj.duration)
      
      redirect_to job_url(@job)
  
    end


  end

  def cleaner_schedule

    @cleaner = Cleaner.find(params[:id])

    if params[:index].nil?
      @month = DateTime.now.strftime("%m-%Y")
      start_date, end_date = RepeatableJob.month_bounds(DateTime.now)
    else
      @now = DateTime.now()

      @shift = params[:index]
      index = @now + @shift.to_i.month
      @month = index.strftime("%m-%Y")
      start_date, end_date = RepeatableJob.month_bounds(index)
    end

    @repeatable_jobs = RepeatableJob.where(cleaner_id: params[:id], date: start_date..end_date).order("day ASC")

    @repeatable_job = RepeatableJob.new

  end

  def site_schedule

    @site = Site.find(params[:id])

    if params[:index].nil?
      @month = DateTime.now.strftime("%m-%Y")
      start_date, end_date = RepeatableJob.month_bounds(DateTime.now)
    else
      @now = DateTime.now()

      @shift = params[:index]
      index = @now + @shift.to_i.month
      @month = index.strftime("%m-%Y")
      start_date, end_date = RepeatableJob.month_bounds(index)
    end

    @repeatable_jobs = RepeatableJob.where(site_id: params[:id], date: start_date..end_date).order("day ASC")

    @repeatable_job = RepeatableJob.new

  end


  def copyall

    puts(params)
    schedule_jobs = []
    found = false
    
    if not params[:cleaner_id].nil?
      cleaner = Cleaner.find(params[:cleaner_id])
    end

    if not params[:site_id].nil?
      site = Site.find(params[:site_id])
    end


    params.each do |row|
      if row[0].to_s.include?('checkbox') 
        n = row[0].split('_')[1]
        puts(params[row[0]])
        if params[row[0]] == '1'
          found = true
          schedule_jobs.append(n)
        end
      end
    end

    if found
      
      jobs_to_copy = RepeatableJob.find(schedule_jobs)
      
      jobs_to_copy.each do |job|

        result, target_string = RepeatableJob.already_exist?(job)

        if result
          
          puts("Esiste")

        else
          
          puts("Non esiste")
          @job = Job.create(date: target_string, site_id: job.site_id, cleaner_id: job.cleaner_id, duration: job.duration)

        end

      end

      redirect_to jobs_week_url

    else

      puts("Nessun elemento selezionato")

    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repeatable_job
      @repeatable_job = RepeatableJob.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def repeatable_job_params
      params.require(:repeatable_job).permit(:day, :hour, :duration, :date, :cleaner_id, :site_id)
    end
end
