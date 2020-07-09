module Slugify 
  extend ActiveSupport::Concern

  def slug 
    username.downcase.gsub(' ','-')
  end 

  class_methods do 
    def find_by_slug(slug)
      self.all.find{|record| record.slug == slug}
    end 
  end 

end 