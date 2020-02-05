require 'rails_helper'

RSpec.describe Blog, type: :model do

  it "Validation does not pass if the title is empty" do
    blog = Blog.new(title: '', content: 'Failure test')
    expect(blog).not_to be_valid
  end

  it "Validation does not pass if content is empty" do
  blog = Blog.new( title: 'failure test' , content: '' )
    expect(blog).not_to be_valid
  end

  it "validation passes If content is described in title and content" do
    # Describe the contents here
    blog = Blog.new(title: 'Valid', content: 'Valid', status: 'off')
    expect(blog).to be_valid
    
  end
end