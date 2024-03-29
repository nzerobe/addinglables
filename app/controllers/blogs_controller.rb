class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy] 
  before_action :first_login

  def index
    
#     if params[:blog] && params[:blog][:search]
#       if params[:blog][:title] == "" && params[:blog][:status] == "" 
#         redirect_to blogs_path
#       elsif params[:blog][:title].present? && params[:blog][:status].present?       
#         @blogs = Blog.page(params[:page]).search_title(params[:blog][:title]).search_status(params[:blog][:status]).per(3)
#       elsif params[:blog][:title].present?
# #         
#         @blogs = Blog.page(params[:page]).search_title(params[:blog][:title]).per(3)
#       elsif params[:blog][:status].present?
# #         
#          @blogs =Blog.page(params[:page]).search_status(params[:blog][:status]).per(3)
#        end
#     elsif params[:sort_expired]
#        @blogs = Blog.all.sort_deadline.page(params[:page]).per(3)
#     elsif params[:sort_priority]
#       @blogs = Blog.order('priority DESC').page(params[:page]).per(3)
#       elsif params[:blog][:label_id].present?
# #       @blogs = Blog.search_label(params[:label_id]).page(params[:page]).per(3)
#         labels =  BlogLabel.where('label_id = ?',params[:blog][:label_id]).pluck(:blog_id)
#         blogs = current_user.blogs.find(labels)
#     else
#       @blogs = Blog.all.order('created_at DESC').page(params[:page]).per(3)

#     end
     @blogs = current_user.blogs.with_title(params.dig(:blog, :title))
                                .with_status(params.dig(:blog, :status))
                                .with_label(params.dig(:blog, :label_id))
                                .sorted_by(params.dig(:sort_option))
                                .page(params[:page]).per(3)
  end

  def new

    @blogs = current_user.blogs.build
#     @label_ids = params[:blog][:label_ids]
    @labels = Label.all
  end
  
  def create
   @blogs = current_user.blogs.build(blog_params)
    
    if @blogs.save

      redirect_to blogs_path
      flash[:success] = 'Blog Created!!'
    else
      @labels = Label.all
      render 'new'
    end
  end
  
 
  def show
   @blogs = Blog.find(params[:id])
    @labels = Label.all
  end
  
  def edit
     @blogs = Blog.find(params[:id])
    @labels = Label.all
  end
    
  def update
    @blogs = Blog.find(params[:id])
    @labels = Label.all
    if @blogs.update(blog_params)
      redirect_to blogs_path, Notice: "You have edited this blog！"
    else
      render 'edit'
    end
  end
  
  def destroy
    @blog.destroy
    redirect_to blogs_path, Notice: "You have deleted the blog!"
  end
  
  private

  def blog_params
    params.require(:blog).permit(:title, :content, :deadline, :status, :priority, :user_id, label_ids: [])
  end
   
  def set_blog
    @blog = Blog.find(params[:id])
  end
  
  
end  

