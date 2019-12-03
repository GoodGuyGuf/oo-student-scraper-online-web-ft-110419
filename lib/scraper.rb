require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_array = doc.css(".student-card a")

    student_array.map do |student|

      {:name => student.css("h4").text,
      :location => student.css("p").text,
      :profile_url => student.attr('href')}
#binding.pry
  end
end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    return_hash = {}
      profile = doc.css(".vitals-container .social-icon-container a")

      profile.each do |element|
        if element.attr('href').include?("twitter")
          return_hash[:twitter] = element.attr("href")

        elsif  element.attr('href').include?("linkedin")
          return_hash[:linkedin] = element.attr("href")

        elsif  element.attr('href').include?("github")
          return_hash[:github] = element.attr("href")

        elsif  element.attr('href').end_with?("com/")
          return_hash[:blog] = element.attr("href")

        end
      end
      return_hash[:profile_quote] = doc.css(".profile-quote").text
      return_hash[:bio] = doc.css(".description-holder p").text
      return_hash
      #binding.pry
    end

end
