class BankAccountsController < ApplicationController
  def new
    @bank_account = current_user.build_bank_account
  end

  def create
    @bank_account = current_user.build_bank_account(bank_account_params)
    if @bank_account.save
      redirect_to mypage_path, notice: '口座情報を登録しました。'
    else
      render :new
    end
  end

  def edit
    @bank_account = current_user.bank_account
  end

  def update
    @bank_account = current_user.bank_account
    if @bank_account.update(bank_account_params)
      redirect_to mypage_path, notice: '口座情報を更新しました。'
    else
      render :edit
    end
  end

  private
  def bank_account_params
    params.fetch(:bank_account, {}).permit(
      :bank_name, :bank_branch_name, :bank_account_number
    )
  end

end
