class Admin::EnqueteAnswersController < AdminController
  before_action :set_enquete_answer

  def edit
  end

  def update
    if @enquete_answer.update(enquete_answer_params)
      redirect_to admin_enquete_url(@enquete_answer.enquete), notice: 'Update enquete answer'
    else
      render :edit
    end
  end

  def destroy
    @enquete_answer.destroy
    redirect_to admin_enquete_url(@enquete_answer.enquete), notice: 'Delete enquete answer'
  end

  private

  def set_enquete_answer
    @enquete_answer = EnqueteAnswer.find(params[:id])
  end

  def enquete_answer_params
    params.fetch(:enquete_answer, {}).permit(
      :enquete_item_id, :enquete_id, :string_value, :boolean_value, :integer_value
    )
  end
end
