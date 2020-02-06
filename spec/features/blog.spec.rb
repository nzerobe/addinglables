# In this require, the feature required for Feature Spec such as Capybara are available.
require 'rails_helper'

# On the right side of this RSpec.feature, write the test item name like "task management feature" (grouped by do ~ end)
RSpec.feature "Blog management function", type: :feature do
  # In scenario (alias of it), write the processing of the test for each item you want to check.
  background do

    user = User.create!(name: "admin", email: 'adminn@gmail.com',  password: 'admin0011')
    Blog.create!(title: 'test_blog_01', content: 'testtesttest', status: 'Off', user: user)
    Blog.create!(title: 'test_blog_02', content: 'samplesample', status: 'Off', user: user)

    visit  root_path
    fill_in  'Email' ,  with: 'adminn@gmail.com'
    fill_in  'Password' ,  with: 'admin0011'
    click_on 'Log in'
  end

  scenario " Testing blog creation "  do
    visit new_blog_path
    fill_in 'blog_title', with: 'testtesttest'
    fill_in 'blog_content', with: 'samplesample'
    select('Pending', from: 'blog[status]')
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
    blog1 = Blog.first
    blog2 = Blog.second
    visit root_path
    expect(Blog.order("updated_at desc").map(&:id)).to eq [blog2.id, blog1.id]
  end

  scenario " Blog completion deadline entry test "  do
    visit new_blog_path
    fill_in 'blog_title', with: 'testtesttest'
    fill_in 'blog_content', with: 'samplesample'
    fill_in 'blog_deadline', with: '2019-02-02'
    select('Pending', from: 'blog[status]')
    click_on 'Create Blog'
    expect(page).to have_content '2019'
  end

  scenario "Blog search execution test by title" do
    visit blogs_path
    fill_in 'blog[title]', with: 'test'
    click_on 'Search'
    sleep 2
    expect(page).to have_content 'testtesttest'
  end

  scenario "Blog search execution test by status" do
    visit root_path
    fill_in 'blog_title', with: ''
    select 'Off', from: 'blog[status]'
    click_on 'Search'
    expect(page).to have_content 'testtesttest'
  end

  scenario "Blog search execution test by title and status " do
    visit root_path
    fill_in 'blog_title', with: 'test_'
    select 'Off', from: 'blog[status]'
    click_on 'Search'
    expect(page).to have_content 'samplesample'
  end

  scenario "Priority descending sort test " do
    visit root_path
    click_on 'Sort By Priority'
    expect(Blog.order("priority ASC").each)
  end
end