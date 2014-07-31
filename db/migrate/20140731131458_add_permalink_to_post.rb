class AddPermalinkToPost < ActiveRecord::Migration
  def change
    update_permalink
  end
end

private
  def update_permalink
    post_titles = Post.all
    post_titles.each do |p_title|

     title = p_title.title.parameterize
     title+=rand(1 .. 50).to_s  
	 row_perma= 'www.' + "#{title}" + '.com'
     p_title.update_attributes(:permalink=>row_perma) 
   end 
end  

