# In this require, the feature required for Feature Spec such as Capybara are available.
require 'rails_helper'

# On the right side of this RSpec.feature, write the test item name like "task management feature" (grouped by do ~ end)
RSpec.feature "Blog management function", type: :feature do
  # In scenario (alias of it), write the processing of the test for each item you want to check.
  background do

  Blog.create!(title: 'test_blog_01', content: 'testtesttest', status: 'off')
  Blog.create!(title: 'test_blog_02', content: 'samplesample', status: 'off')

 
  visit blogs_path

end

scenario "Test blog list" do
  # Create two tasks in advance to use in the task list test
 
end
  
 scenario " Testing blog creation "  do
    visit new_blog_path
    fill_in 'blog_title', with: 'testtesttest'
    fill_in 'blog_content', with: 'samplesample'
   click_on 'Create Blog'
    expect(page).to have_content'testtesttest'
    expect(page).to have_content'samplesample'
  end
  
  scenario " Testing Blog Details "  do
    blog = Blog.create!(title:"testtesttest",content:"samplesample",status: 'off')
    visit blog_path(blog.id)
    expect(page).to have_content "samplesample"
  end
  
  scenario "Test whether blogs are arranged in descending order of creation date" do
 
    visit root_path
    
#     
     expect(Blog.order("updated_at desc").map(&:id)).to eq [ 10, 9]

  end
  
   scenario " Blog completion deadline entry test "  do
    visit new_blog_path
    fill_in 'blog_title', with: 'testtesttest'
    fill_in 'blog_content', with: 'samplesample'
    fill_in 'blog_deadline', with: DateTime.now
    click_on 'Create Blog'
    expect(page).to have_content '2019'
  end
  
   scenario "Blog search execution test by title" do
    visit root_path
    fill_in 'title', with: '01'
    click_on 'search'
    expect(page).to have_content 'samplesample'

  end

  scenario "Blog search execution test by status" do
    visit root_path
    fill_in 'title', with: ''
    select 'Off', from: 'status'
    click_on 'search'
    expect(page).to have_content 'samplesample'

  end

  scenario "Blog search execution test by title and status " do
    visit root_path
    fill_in 'title', with: 'test_'
    select 'Off', from: 'status'
    click_on 'search'
    expect(page).to have_content 'samplesample'

  end

  scenario "Priority descending sort test " do
    visit root_path
    click_on 'Sort in order of priority'
     expect(Blog.order("priority ASC").each)
  end

  
end