class AddPermalinkToPost < ActiveRecord::Migration
  def change
  	add_column :posts,:permalink, :string
    update_permalink
  end
end

private
  def update_permalink
    post_titles = Post.all
    post_titles.each do |p_title|
     title= (0...5).map { p_title.title[rand(p_title.title.length)]}.join    # generate random string with help of title
     row_perma= 'www.' + "#{title}" + '.com'
     p_title.update_attributes(:permalink=>row_perma) 
   end 
end  

