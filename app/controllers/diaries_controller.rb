class DiariesController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :update, :json]

  def index
    @searchDate = convertDate(params[:date]) ? convertDate(params[:date]) : Date.today

    @diaries = Diary.includes(:comments, :user).opened.where("date = ?", @searchDate).merge(Comment.order("comments.created_at DESC"))

    @start_of_month = Date.new(@searchDate.year, @searchDate.month, 1);
    @end_of_month = Date.new(@searchDate.year, @searchDate.month, -1);

    @comment = Comment.new

  end

  def new
    edit_date = params[:date].nil? ? Date.today : params[:date]

    resitered_diaries = Diary.find_date_and_user_id(edit_date, current_user.id)
    if resitered_diaries.present?
      @diary = resitered_diaries.first
    else
      @diary = Diary.new
      @diary.date = Date.today
    end
  end

  def create

    # すでに日報が登録されている場合は更新する
    resitered_diaries = Diary.find_date_and_user_id(diary_params[:date], current_user.id)
    if resitered_diaries.present?
      @diary = resitered_diaries.first
      if @diary.update_attributes(diary_params)
        flash[:success] = "すでに日報が存在していたため、変更されました"
        redirect_to @current_user and return
      else
        render 'new' and return
      end
    end

    @diary = Diary.new(diary_params)
    @diary.user_id = current_user.id

    if @diary.save
      flash[:success] = "新しい日報が登録されました"
      redirect_to @current_user
    else
      render 'new'
    end
  end

  def update
    create
  end

  def json
    resitered_diaries = Diary.find_date_and_user_id(params[:date], current_user.id)
    if resitered_diaries.empty?
      render :json => { status: "failure", diary: {} }
    else
      diary = resitered_diaries.first
      render :json => { status: "success", diary: diary }
    end
  end

  private

    def diary_params
      diary_params = params.require(:diary).permit(:date, :diary, :status)
      return diary_params
    end

    def convertDate(str_date)
      until str_date
        return nil
      end

      begin
        date = Date.parse(str_date)
      rescue ArgumentError
      end
    end

end
