class LabelsController < ApplicationController

  def create
    @label = Label.new(label_params)
    @label.save
    redirect_to root_path, notice: "Label Created!!"
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy
    redirect_to labels_path, notice: "Label Deleted!!"
  end

  private
  def label_params
    params.require(:label).permit(:name)
  end

end